defmodule Cookpod.Catalog.RecipleFsm do
  use Fsm, initial_state: :draft

  # opens the state scope
  defstate draft do
    # defines event
    defevent publish do
      # transition to next state
      next_state(:published)
    end
  end

  defstate published do
  end
end
