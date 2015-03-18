#rspec 

## link

[site officiel ](http://rspec.info/)
[environnement de développement](https://github.com/rspec/rspec-dev)
[contribute note](https://github.com/rspec/rspec/wiki/Contribute)

## core
[rspec-core issue list ](https://github.com/rspec/rspec-core/issues)


## commandes
cloner le repo et obtenir les sous repos
 hub clone rspec/rspec-dev
 cd rspec-dev
 bundle install --binstubs
 bin/rake setup
 cd repos
 cd rspec-core

## bugs 

### profile group

https://github.com/rspec/rspec-core/issues/1878

"Top N Slowest Example Group" from `--profile` does not account for time spent in `before(:context)` hooks

"The implementation calculates the total example group time by summing the time of each individual example. Problem is, the time in before/after :context hooks is not included in individual example times so it's completely ignored. This should be fixed, because if you are using :context hooks it may be because of a slow operation and you wouldn't want it ignored when trying to find the slowest example groups."

features/configuration/profile.feature

spec/core/configuration_option_spec.rb:255 describe "--profile, -p" do (parsing)

## écrire une feature

une première feature écrite :

features/configuration/profile_groupe.feature

## vérifier la feature avec maintainer sur github
https://github.com/rspec/rspec-core/issues/1878


## trouver le code
lib/rspec/core/formatters/profile_formatter.rb
  dump_profile
    dump_profile_slowest_example_groups

lib/rspec/core/notifications.rb
  calculate_slowest_groups (bingo!)


## verifier s'il y as une spec qui exécute ce code
- faire une recherche pour la méthode dans le dossier de spec
  calculate_slowest_groups
- remonter les calls et les rechercher dans le dossier de spec
  slowest_groups
- mettre un abort dans la définition de la fonction
- passer dans les 15 définition


/spec/rspec/core/formatters/profile_formatter_spec.rb  RSpec::Core::Formatters::ProfileFormatter
77 ## dump_profile with multiple example groups prints the time
81 ## dump_profile with multiple example groups ranks the example groups by average time
__73 ## dump_profile with multiple example groups prints the slowest example groups__

irrelevant
21 ## dump_profile with one example group it should behave like profiles examples prints the time
25 ## dump_profile with one example group it should behave like profiles examples prints the path
30 ## dump_profile with one example group it should behave like profiles examples prints the percentage taken from the total runtime
17 ## dump_profile with one example group it should behave like profiles examples names the example
34 ## dump_profile with one example group it should behave like profiles examples doesn't profile a single example group

/spec/rspec/core/formatters/json_formatter_spec.rb # RSpec::Core::Formatters::JsonFormatter
173 ## dump_profile with multiple example groups provides information
177 ## dump_profile with multiple example groups ranks the example groups by average time
169 ## dump_profile with multiple example groups provides the slowest example groups

__irrelevant__
139 ## dump_profile with one example group provides example execution time
143 ## dump_profile with one example group doesn't profile a single example group
147 ## dump_profile with one example group has the summary of profile information
135 ## dump_profile with one example group names the example
