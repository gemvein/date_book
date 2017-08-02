module DateBook
  class EventsController < DateBookController
    load_resource find_by: :slug

    # GET /events
    # GET /events.json
    def index
      start_date = params[:start]&.to_datetime || Time.now.beginning_of_month
      end_date = params[:end]&.to_datetime || Time.now.beginning_of_month.next_month
      @events = @events.ending_after(start_date).starting_before(end_date)
    end

    # GET /events/1
    # GET /events/1.json
    def show
      if params[:occurrence_id].present?
        @occurrence = @event.event_occurrences.find(params[:occurrence_id])
      end
    end

    # GET /events/new
    # GET /events/new.json
    def new
    end

    # GET /events/1/edit
    # GET /events/1/edit.json
    def edit
    end

    # POST /events
    # POST /events.json
    def create
      if @event.save
        redirect_to @event, notice: :item_acted_on.l(item: DateBook::Event.model_name.human, action: :created.l)
      else
        render :new
      end
    end

    # PATCH/PUT /events/1
    # PATCH/PUT /events/1.json
    def update
      if @event.update(event_params)
        redirect_to @event, notice: :item_acted_on.l(item: DateBook::Event.model_name.human, action: :updated.l)
      else
        render :edit
      end
    end

    # DELETE /events/1
    # DELETE /events.json
    def destroy
      @event.destroy
      redirect_to events_url, notice: :item_acted_on.l(item: DateBook::Event.model_name.human, action: :destroyed.l)
    end

    private
      # Only allow a trusted parameter "white list" through.
      def event_params
        schedule_attributes = [
          :id,
          :date,
          :time,
          :rule,
          :until,
          :count,
          :interval,
          :all_day,
          {
            day: [],
            day_of_week: [
              {
                monday: [],
                tuesday: [],
                wednesday: [],
                thursday: [],
                friday: [],
                saturday: [],
                sunday: []
              }
            ],
            duration_attributes: [
              :count,
              :unit
            ]
          }
        ]

        params.require(:event).permit(
          :id,
          :name,
          :description,
          schedule_attributes: schedule_attributes
        )
      end
  end
end
