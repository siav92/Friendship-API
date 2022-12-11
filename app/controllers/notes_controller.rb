class NotesController < ApplicationController
  # POST /notes
  def create
    note = Note.new(note_params)

    if @note.save
      render json: note, status: :created, location: note
    else
      render json: note.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /notes/1
  def update
    if note.update(note_params)
      render json: note
    else
      render json: note.errors, status: :unprocessable_entity
    end
  end

  # DELETE /notes/1
  def destroy
    note.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def note
    @note ||= current_user.notes.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def note_params
    params.require(:note).permit(:user_id, :title, :content)
  end
end
