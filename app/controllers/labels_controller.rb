class LabelsController < ApplicationController
  # POST /labels
  def create
    label = Label.new(label_params)

    if label.save
      render json: label, status: :created, location: label
    else
      render json: label.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /labels/1
  def update
    if label.update(label_params)
      render json: label
    else
      render json: label.errors, status: :unprocessable_entity
    end
  end

  # DELETE /labels/1
  def destroy
    label.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def label
    label ||= Label.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def label_params
    params.require(:label).permit(:title, :color)
  end
end
