alias DistributedFileFetcher.ExchangeRate
alias DistributedFileFetcher.Repo

rates = [
  %{currency: "INR", rate: 0.012},
  %{currency: "AED", rate: 0.27},
  %{currency: "GBP", rate: 1.29},
  %{currency: "EUR", rate: 1.09},
  %{currency: "USD", rate: 1.0}
]

Repo.insert_all(ExchangeRate, rates)
