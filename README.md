# Elixir MapReduce

A simple MapReduce framework implemented on top of GenServer and Flow

## Architecture
~- Main Master process is the head of a supervision tree atop two other supervisors~
~- These two supervisors monitor the Mappers and the Reducers~
~- Upon initialization, the Master accepts as arguments a config file and input file~
~- It will first split the input file based on some configuration options into roughly 
equal-sized file chunks; these will be stored in a temp directory~
~- Upon completion of the file splitting, the Master will start up the Mapper supervisor~

~- The Mapper supervisor will distribute all of the file splits to Mapper Tasks, which will
each run the Map function on its respective file split~
~- Each Mapper will output an intermediary file and then send a message to the Mapper supervisor
upon completion of its task~
~- In the case that a Mapper fails, the supervisor will restart that Task with the same file
split it was initially handed~

~- Once all the Mapper Tasks have successfully completed, the Mapper Supervisor sends a message
to the Master, which will then kick off the Reducer supervisor~
~- The Reducer supervisor similarly kicks off a Reduce Task for each intermediary file~
~- Upon success, each Reduce Task notifies the Reducer supervisor, and on failure, the Reducer
supervisor restarts that Task with its initial intermediary file~

~How best to aggregate the output of the Reducers?~

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `elixir_mapreduce` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:elixir_mapreduce, "~> 0.1.0"}]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/elixir_mapreduce](https://hexdocs.pm/elixir_mapreduce).

