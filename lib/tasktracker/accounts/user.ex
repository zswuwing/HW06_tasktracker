defmodule Tasktracker.Accounts.User do
  use Ecto.Schema

  import Ecto.Changeset
  alias Tasktracker.Accounts.User
  alias Tasktracker.Relationship.Supervision


  schema "users" do
    # field :manager, :boolean, default: false
    # field :admin, :boolean, default: false
    field :email, :string, null: false
    field :name, :string, null: false
    field :pass_hash, :string
    field :password, :string, virtual: true
    #belongs_to :supervisor, Tasktracker.Accounts.User
    # has_many :underling_underlings, Supervision , foreign_key: :underling_id
    # has_many :supervisor_underlings, Supervision, foreign_key: :supervisor_id
    # has_many :underlings, through: [:supervisor_underlings, :underling]
    # has_many :supervisors, through: [:underling_underlings, :supervisor]


    timestamps()
  end


  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :name, :pass_hash])
    |> validate_required([:email, :pass_hash])
  end
end
