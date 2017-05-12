defmodule EMR.Master do
  use Supervisor

  def start_link(input) do
    map_kilobytes = Application.get_env(:elixir_mapreduce, :map_kilobytes)
    Supervisor.start_link(__MODULE__, File.stream!(input, [], map_kilobytes * 1000))
  end

  def init(stream) do
    # How to initially monitor one supervisor and then switch to
    # monitoring another one when the first one completes?
    children = [
      supervisor(EMR.Mapper.Supervisor, [stream])
    ]

    supervise(children, strategy: :one_for_one)
  end
end
