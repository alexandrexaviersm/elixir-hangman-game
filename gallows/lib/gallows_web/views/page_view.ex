defmodule GallowsWeb.PageView do
  use GallowsWeb, :view

  def plural_of(string, 1), do: string
  def plural_of(string, 666), do: {:safe, "<span style='color: red'>#{string}</span>"}
  def plural_of(string, number) when number < 0, do: "<span style='color: red'>#{string}</span>"
  def plural_of(string, _), do: string <> "s"
end
