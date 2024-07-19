install.packages("devtools")

git_vaccinate()
use_git_ignore(".Renviron")

use_testthat()
use_roxygen_md()
use_package_doc()
use_spell_check()
use_readme_rmd()
use_news_md()
use_lifecycle()
use_mit_license("CorradoLanera")
use_code_of_conduct("Corrado.Lanera@gmail.com")

use_build_ignore("^dev/", escape = FALSE)
use_lifecycle_badge("experimental")
use_tidy_description()



use_github(organisation = "CorradoLanera", protocol = "ssh")
use_coverage(repo_spec = "CorradoLanera/outscrapr")
use_github_action("test-coverage", badge = TRUE)
use_github_action("check-standard", badge = TRUE)
use_pkgdown_github_pages()




