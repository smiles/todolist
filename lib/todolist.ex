defmodule Todolist do

  use GenServer

  defstruct name: nil, items: [], del_items: [], count: 0

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts)
  end  

  def init(opts) do
    {:ok, %Todolist{name: opts}}
  end

  def handle_call(:name, _from, state) do
    {:reply, state.name, state}
  end 

  def handle_call(:items, _from, state) do
    {:reply, state.items, state}
  end

  def handle_call(:del_items, _from, state) do
    {:reply, state.del_items, state}
  end   

  def handle_cast({:add_item, item}, state) do
    updated_count = %{state| count: state.count + 1}
    {:noreply, %{updated_count | items: state.items ++ [{updated_count.count, item}]}}
  end 

  def handle_cast({:del_item, number}, state) do
    del_added = %{state | del_items: Enum.filter(state.items, fn {x, _y} -> x == number end)}
    update_items = %{del_added | items: Enum.filter(state.items, fn {x, _y} -> x != number end)}
    {:noreply, update_items}
  end   

end
