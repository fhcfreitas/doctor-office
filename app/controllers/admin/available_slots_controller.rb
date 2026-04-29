class Admin::AvailableSlotsController < ApplicationController
  before_action :require_authentication
  before_action :require_admin!
  before_action :set_slot, only: [ :edit, :update, :destroy ]
  layout "admin"

  def index
    @week_offset = params[:week_offset].to_i
    @week_dates  = week_dates(@week_offset)
    @slots       = slots_for_week(@week_offset)
  end

  def new
    @slot = AvailableSlot.new(
      starts_at: parse_datetime(params[:date], params[:hour]),
      ends_at:   parse_datetime(params[:date], params[:hour])&.+(1.hour)
    )
  end

  def create
    @slot = AvailableSlot.new(slot_params.merge(user: Current.user))
    if @slot.save
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream_calendar_response(params[:week_offset].to_i) }
        format.html { redirect_to admin_available_slots_path(week_offset: params[:week_offset]), notice: "Slot criado com sucesso." }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @slot.update(slot_params)
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream_calendar_response(params[:week_offset].to_i) }
        format.html { redirect_to admin_available_slots_path(week_offset: params[:week_offset]), notice: "Slot atualizado." }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @slot.update!(status: :cancelled)
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream_calendar_response(params[:week_offset].to_i) }
      format.html { redirect_to admin_available_slots_path(week_offset: params[:week_offset]), notice: "Slot cancelado." }
    end
  end

  private

  def set_slot
    @slot = AvailableSlot.find(params[:id])
  end

  def slot_params
    params.require(:available_slot).permit(:starts_at, :ends_at, :status)
  end

  def week_dates(offset)
    today  = Date.current
    monday = today - ((today.wday - 1) % 7).days + (offset * 7).days
    monday..(monday + 4.days)
  end

  def slots_for_week(offset)
    dates = week_dates(offset)
    AvailableSlot.where(user: Current.user)
                 .where(starts_at: dates.first.beginning_of_day..dates.last.end_of_day)
                 .order(:starts_at)
  end

  def parse_datetime(date, hour)
    return nil unless date.present? && hour.present?
    Time.zone.parse("#{date} #{hour}")
  end

  def turbo_stream_calendar_response(offset)
    [
      turbo_stream.update("modal", ""),
      turbo_stream.replace("calendar",
        partial: "admin/available_slots/calendar",
        locals: {
          week_dates: week_dates(offset),
          slots:      slots_for_week(offset),
          week_offset: offset
        })
    ]
  end
end
