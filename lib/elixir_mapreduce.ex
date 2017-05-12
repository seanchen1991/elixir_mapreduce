defmodule EMR do
  use Application

  @moduledoc """
  Documentation for EMR.
  """

  def main(args \\ []) do
    if File.exists?(args) do
      EMR.Master.start_link(args)
    else 
      IO.puts "Please input a valid file path"
    end
  end
  
end
