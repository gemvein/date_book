require_dependency "date_book/application_controller"

module DateBook
  class EventsController < ApplicationController
    load_and_authorize_resource

    # GET /events
    def index
      @events = Event.all
    end

    # GET /events/1
    def show
    end

    # GET /events/new
    def new
      @event = Event.new
    end

    # GET /events/1/edit
    def edit
    end

    # POST /events
    def create
      @event = Event.new(event_params)

      if @event.save
        redirect_to @event, notice: 'Event was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /events/1
    def update
      if @event.update(event_params)
        redirect_to @event, notice: 'Event was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /events/1
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
