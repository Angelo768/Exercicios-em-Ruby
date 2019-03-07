class AddressesController < ApplicationController
  before_action :set_contact

  # GET /contact/1/address
  def show
    render :json => @contact.address
  end

  # POST /contact/1/address
  def create
    @contact.address = Address.new(address_params)

    if @contact.save
      render :json => @contact.address, status: :created, location: @contact_address_url(@contact)
    else
      render :json => @contact.errors, status: :unprocessable_entity
    end
  end

  #PATCH/PUT /contact/1/address
  def update
    if @contact.address.update(address_params)
      render :json => @contact.address
    else
      render :json => @contact.erros, status: :unprocessable_entity
    end
  end

  def destroy
    @contact.address.destroy
  end

  private

  def set_contact
    @contact = Contact.find(params[:contact_id])
  end

  def address_params
    params.require(:contact).permit(:street, :city)
  end
end
