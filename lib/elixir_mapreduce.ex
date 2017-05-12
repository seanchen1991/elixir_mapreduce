defmodule EMR do
  use Application

  @moduledoc """
  Documentation for EMR.
  """
  
  def start(_type, _args) do
    EMR.Master.start_link()
  end
  
end
