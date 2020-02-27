shopping_list = [
  {"1 dozen", "eggs"},
  {"1 ripe", "melon"},
  {"4", "apples"},
  {"2 boxes", "tea"}
]

template = """
quantity | item
--------------------
<%= for {qtd, item} <- shopping_list do %>
<%= String.pad_leading(qtd, 8)%> | <%= item %>
<% end %>
"""

IO.puts(EEx.eval_string(template, [shopping_list: shopping_list], trim: true))
