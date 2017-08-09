# frozen_string_literal: true

module DateBook
  # Allows viewing and maintaining Calendars
  class CalendarsController < DateBookController
    load_and_authorize_resource find_by: :slug

    # GET /calendars
    def index; end

    # GET /calendars/slug
    def show; end

    # GET /calendars/new
    def new; end

    # GET /calendars/slug/edit
    def edit; end

    # POST /calendars
    def create
      @calendar.owners = [current_user]
      unless @calendar.save
        flash[:error] = @calendar.errors.full_messages.to_sentence
        render :new
        return
      end
      redirect_to(@calendar, notice: :item_acted_on.l(
        item: Calendar.model_name.human,
        action: :created.l
      ))
    end

    # PATCH/PUT /calendars/slug
    def update
      unless @calendar.update(calendar_params)
        flash[:error] = @calendar.errors.full_messages.to_sentence
        render :edit
        return
      end
      redirect_to(@calendar, notice: :item_acted_on.l(
        item: Calendar.model_name.human,
        action: :updated.l
      ))
    end

    # DELETE /calendars/slug
    def destroy
      @calendar.destroy
      redirect_to(
        calendars_url,
        notice: :item_acted_on.l(
          item: Calendar.model_name.human,
          action: :destroyed.l
        )
      )
    end

    private

    # Only allow a trusted parameter "white list" through.
    def calendar_params
      params.require(:calendar).permit(
        :id,
        :name,
        :description,
        :css_class
      )
    end
  end
end
