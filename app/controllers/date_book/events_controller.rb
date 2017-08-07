module DateBook
  class EventsController < DateBookController
    load_and_authorize_resource find_by: :slug
    before_action :set_occurrence, only: [:show, :popover]

    # GET /events
    # GET /events.json
    def index
      start_date = params[:start]&.to_datetime || Time.now.beginning_of_month
      end_date = params[:end]&.to_datetime || Time.now.beginning_of_month.next_month
      @events = @events.ending_after(start_date).starting_before(end_date)
      respond_to do |format|
        format.html
        format.json { render json: @events.to_list }
      end
    end

    # GET /events/slug
    # GET /events/slug.json
    def show
      respond_to do |format|
        format.html
        format.json { render json: @event.to_list }
      end
    end

    # GET /events/slug/popover
    def popover
      render layout: 'blank'
    end

    # GET /events/new
    def new
    end

    # GET /events/slug/edit
    def edit
    end

    # POST /events
    def create
      @event.owners = [current_user]
      if @event.save
        redirect_to @event, notice: :item_acted_on.l(item: Event.model_name.human, action: :created.l)
      else
        flash[:error] = @event.errors.full_messages.to_sentence
        render :new
      end
    end

    # PATCH/PUT /events/slug
    def update
      if @event.update(event_params)
        redirect_to @event, notice: :item_acted_on.l(item: Event.model_name.human, action: :updated.l)
      else
        flash[:error] = @event.errors.full_messages.to_sentence
        render :edit
      end
    end

    # DELETE /events/slug
    def destroy
      @event.destroy
      redirect_to events_url, notice: :item_acted_on.l(item: Event.model_name.human, action: :destroyed.l)
    end

    private
      def set_occurrence
        if params[:occurrence_id].present?
          @occurrence = @event.event_occurrences.find(params[:occurrence_id])
        end
      end

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
          :css_class,
          schedule_attributes: schedule_attributes
        )
      end
  end
end
