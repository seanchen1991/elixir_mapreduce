defmodule EMR.Master do
  use Supervisor

  def start_link do 
    Supervisor.start_link(__MODULE__, :ok)
  end

  defp split_files do
    input_file = Path.wildcard(Application.get_env(:elixir_mapreduce, :input_dir))
    n_file_splits = Application.get_env(:elixir_mapreduce, :n_file_splits)

    file_sizes = input_files
  end

  def init(:ok) do
    # Not actually what we want
    # How to initially monitor one supervisor and then switch to
    # monitoring another one when the first one completes?
    children = [
      supervisor(EMR.Mapper.Supervisor, EMR.Reducer.Supervisor, [])
    ]

    supervise(children, strategy: :one_for_one)
  end
end
