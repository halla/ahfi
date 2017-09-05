defmodule Ahfi.Contact.Email do
  import Swoosh.Email
  alias Ahfi.ContactForm

  @name Application.get_env(:ahfi, :email)[:name]
  @address Application.get_env(:ahfi, :email)[:address]
  def send(%ContactForm{} = form) do
      new
      |> to({@name, @address})
      |> from({"anttihalla.fi", "no-reply@anttihalla.fi"})
      |> subject("[AHFI] Contact from " <> form.name)
      |> text_body(form.body)
  end
end
