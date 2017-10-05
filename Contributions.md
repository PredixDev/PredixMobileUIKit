Contributions
===

This project is led by GE Digital and open to the community. Anyone with an interest in the project can join the community and contribute to the project. GE Digital is responsible for general strategic line of the project, the ensurance of quality, and resolving any community disagreement. It is GE Digital’s job to resolve disputes within the community and to ensure that the project is able to progress in a coordinated way. In turn, it is the community’s job to guide the decisions of GE Digital through active engagement and contribution.

### Roles and responsibilities

#### Users

Users are community members who have a need for the project. They are the most important members of the community and without them the project would have no purpose. Anyone can be a user; there are no special requirements.

The project asks its users to participate in the project and community as much as possible. User contributions enable the project team to ensure that they are satisfying the needs of those users. Common user contributions include (but are not limited to):

* evangelising about the project (e.g. a link on a website and word-of-mouth awareness raising)
* informing developers of strengths and weaknesses from a new user perspective
* providing moral support (a ‘thank you’ goes a long way)

Users who continue to engage with the project and its community will often become more and more involved. Such users may find themselves becoming contributors, as described in the next section. 

#### Contributors

Contributors are community members who contribute in concrete ways to the project. Anyone can become a contributor, and contributions can take many forms.

In addition to their actions as users, contributors may also find themselves doing one or more of the following:

* supporting new users (existing users are often the best people to support new users)
* contributing to online forums
* reporting bugs
* identifying requirements
* programming
* writing documentation
* fixing bugs
* adding features

Contributors engage with the project through the issue tracker and online forums, or by writing or editing documentation. They submit changes to the project itself via pull requests, which will be considered for inclusion in the project by Reviewers (see next section). The developer online forums is the most appropriate place to ask for help when making that first contribution.

As contributors gain experience and familiarity with the project, their profile within, and commitment to, the community will increase, and their influence and access to the Project Leads will increase.

#### Project Leads

Project Leads consists of those individuals identified as ‘project owners’ on the development site. Project leads are responsible for reviewing and accepting Contributor pull requests, ensure the smooth running of the project, participate in strategic planning, approve changes to the governance model and manage the copyrights within the project outputs. Currently, all Project Leads are GE Digital employees, and members of the Predix Mobile team. 

### Support

All participants in the community are encouraged to provide support for new users within the project management infrastructure. This support is provided as a way of growing the community. Those seeking support should recognise that most support activity within the project is voluntary and is therefore provided as and when time allows. A user requiring guaranteed response times or results should therefore seek to purchase a support contract from GE Digital. However, for those willing to engage with the project on its own terms, and willing to help support other users, the community support channels are ideal.

### Contribution process

Anyone can contribute to the project, regardless of their skills, as there are many ways to contribute. For instance, a contributor might be active on the Predix Forums and issue tracker, or might supply patches. 

The Predix Forums is the most appropriate place for a contributor to ask for help when making their first contribution. 

All code and documentation contributions will envolve a Pull Request process. For code pull requests, either for bug fixes, or feature enhancements the following minimum requirements must be met before the code will be reviewed by a Project Lead:

* A valid Github pull request must be entered
* The pull request must have no conflicts with the base branch
* Pull requests should have a base branch of `develop`, or a feature branch. No pull requests with a base branch of `master` will be considered,
* All validation checks must pass, these may include, but not be limited to:
	* The code compiles on all supported platforms
	* All unit tests pass on all supported platforms
	* Code coverage is at an acceptably high level
	* All public API is documented with in-code documentation
	* Standard Swift code formatting compliance

Additionally, during review, the Project Leads may require:

* Additional unit test coverage, particularly edge cases and validations
* Additional or clarifying code documentation
* New features may require additional documentation
* Justification/explaination of newly proposed features
* Reference to the tracked Issue the pull request resolves
* Additional code formatting or structure compliance

Pull request acceptance is entirely within the Project Lead's purview. The project leads work hard to be fair and consistent, but past acceptance is no guarantee of future acceptance. The project is iterative, and continously evolving, include the quality standards which are accepted. The project leads may require new pull requests to meet additional requirements at any time.
 
Once a pull request is submitted, it must remain active or it will be closed. If the validation checks fail or the reviewer has asked for changes or clarifying information and the contributor has not responded, the pull request may be closed without further warning. Contributors are free to resubmit those changes in a new pull request.


	
Further references:

[Apple Xcode code documentation markup reference](https://developer.apple.com/library/content/documentation/Xcode/Reference/xcode_markup_formatting_ref/index.html)

[Swift API Design Guidelines](https://swift.org/documentation/api-design-guidelines/)

