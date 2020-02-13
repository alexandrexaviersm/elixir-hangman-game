defmodule HangmanBoot do
  defdelegate start(), to: TextClient.Interact
end
