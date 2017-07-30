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
        redirect_to @event, notice: 'Event was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /events/1
    # PATCH/PUT /events/1.json
    def update
      if @event.update(event_params)
        redirect_to @event, notice: 'Event was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /events/1
    # DELETE /events.json
    def destroy
      @event.destroy
      redirect_to events_url, notice: 'Event was successfully destroyed.'
    end

    private
      # Only allow a trusted parameter "white list" through.
      def event_params
        params.require(:event).permit(:name, :description)
      end
  end
end
