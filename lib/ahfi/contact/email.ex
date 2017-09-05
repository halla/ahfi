defmodule Ahfi.Contact.Email do
  import Swoosh.Email
  alias Ahfi.ContactForm


  @from Application.get_env(:ahfi, :email)[:from]
  @to Application.get_env(:ahfi, :email)[:to]
  def send(%ContactForm{} = form) do
      new
      |> to(@to)
      |> from(@from)
      |> subject("[AHFI] Contact from " <> form.name)
      |> text_body(form.body)
  end
end
