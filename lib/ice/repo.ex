defmodule Ice.Repo do
  use AshPostgres.Repo, otp_app: :ice

  def min_pg_version do
    %Version{major: 16, minor: 0, patch: 0}
  end

  def prefer_transaction? do
    false
  end

  def installed_extensions do
    ["ash-functions"]
  end
end
