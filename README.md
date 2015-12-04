== README

This README would normally document whatever steps are necessary to get the
application up and running.

# branch gitflow workflow

我们将使用gitflow workflow，他大概会用到如下分支
master development staging feature release hotfix

* master 

主干稳定分支，生产环境中的部署从此分支取代码，除了线上bug临时修复，它不接受任何
merge request，只能管理人员把release分支merge到master做deploy

* development

开发分支，不允许开发人员直接push，只能通过merge request，由项目的管理者做merge

* staging 

最新不稳定分支，开发人员可以随意将代码合并push到此分支，该分支存在的意义是给所有
开发者一个环境测试目前的代码的表现

* feature

这个分支并不实际存在，而是多个feature分支的统称，原则上每个功能都应该打一个
feature branch并push到remote以供将来做merge request到development分支

* release

预上线分支，每次发版前，从development分支branch off到release分支，该分支存在的意
义是在每次发版前有一个强制封版，一旦branch off到此分支，代表该版本的功能性开发完
毕，剩下的工作是一些细微bug的修复，以及为了部署而做的一些准备工作，一旦这些工作
完毕，则将该分支merge到master上，此时就可以做deploy并打上tag，不要忘记release需
要merge回development中，而一旦这些做完，release是可以删除的，等到下次封版，再行
创建，当然也可以不删除，等到下次封版，将development分支merge到release

* hotfix

并不是一个实际存在的分支，代表着我们对所有线上bug的统称，每个线上bug，原则上我们
要打一个诸如hotfix#123的分支，123代表issue号，一旦该issue修复完毕，就将对应分支
合并到master上，做deploy，同时不应忘记将其merge到development或者release中

关于gitflow workflow的详细说明，参见https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow