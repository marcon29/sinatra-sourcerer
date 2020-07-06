# sinatra-sourcerer
Collect online sources in one place and access them via any internet connected device. Completely custom organization by subject and topic. Share sources, if desired, with others researching the same topic. 


## Installation

1. Fork and clone this repo.
2. Pull your repo to your local environment.
3. In your CLI, navigate to the folder you cloned the code files to. Then execute (requires Bundler):

    $ bundle install


## Usage

### Running the App
In your CLI, run the shotgun server:

    $ shotgun

Once server is running, enter the following url into your browser:

    $ localhost:9393

View this video to review basic use:
    [Video Walkthrough](https://drive.google.com/file/d/1pbP3M0zWGsu53LDGf1ux5qBtBxr5LzPt/view?usp=sharing)

### Signup and Login Profile
You must sign up as a user to use the app.

To sign up:
1. Click on "Signup"
2. Fill out and submit form (all are required)
3. Your username and email must be unique
4. After a valid signup, you will automatically be logged in
5. Once logged in, you will be taken to your home page that displays all your subjects and topics

To log in:
1. Click on "Login"
2. Fill out and submit form (all are required)
3. After validating your info, you will be taken to your home page that displays all your subjects and topics

### Creating New Items
Creating a Subject:
1. Click on "Add Subject"
2. Fill out the Name and Description fields
    2a. The name is required and must be unique
3. You'll also have the ability to create a new topic at the same time (optional)
4. Click on the "Add Subject" button at the bottom to submit your info

Creating a Topic:
1. Click on "Add Topic"
2. Fill out the Name and Description fields
    2a. The Name is required and must be unique 
3. You must assign the topic to a subject (note: a topic can only be in one subject)
    3a. You can either select from your existing subjects or
    3b. You can create a new subject
    3c. If you select both an existing subject and create a new one, the topic will only go in the newly created topic
4. Click on the "Add Topic" button at the bottom to submit your info

Creating a Source:
1. Click on "Add Source"
2. Fill out the form in the Source Info section
    2a. The Name and URL are required and both must be unique
3. You must assign the source to a topic (note: a source can go in as many topics as you like, but must be in at least one)
    3a. You can either select from your existing topics (multiple is ok) or
    3b. You can create a new topic
    3c. If you select both an existing topic and create a new one, the source will go in both topics
4. If you create a new topic, you must also assign the new topic to a subject (note: a topic can only be in one subject)
    3a. You can either select from your existing subjects or
    3b. You can create a new subject
    3c. If you select both an existing subject and create a new one, the topic will only go in the newly created topic
5. If you want the source to be found by other users, check the Public box (see below for more details)
6. Click on the "Add Source" button at the bottom to submit your info

### Editing Items
Editing a Subject:
1. From the Home page, click on the "Edit Subject" button
2. A form pre-filled with current info will be displayed
3. Change whatever info you wish (same rules apply for creating a new subject - see above)
4. If you check any other boxes in the Associated Topics section, those topics will be moved from their existing subject into the currently displayed one
5. Click on the "Update" button at the bottom to submit your info

Editing a Topic:
1. From the Home page, click on the topic you wish to edit (will take you to the topic page)
2. Click on the "Edit Topic" button (at top of page, next to topic name)
3. A form pre-filled with current info will be displayed
4. Change whatever info you wish (same rules apply for creating a new source - see above)
5. If you check any other boxes in the Associated Subjects section, the currently displayed topic will be moved to the selected subject (or the new one if added)
6. Click on the "Update" button at the bottom to submit your info

Editing a Source:
1. From the Home page, click on the topic that contains the source you wish to edit (will take you to the topic page)
2. Click on the "Edit Source" button for the source you want to edit (each source will have its own button)
    2a. You can also click on the "Source Details" button to go the source page, where you can also select to edit the source
3. A form pre-filled with current info will be displayed
4. Change whatever info you wish (same rules apply for creating a new source - see above)
5. Click on the "Update" button at the bottom to submit your info

### Deleting Items & Orphan Control
Deleting a Subject:
1. From the Home page, click on the "Delete Subject" button

Deleting a Topic:
1. From the Home page, click on the topic you wish to edit (will take you to the topic page)
2. Click on the "Delete Topic" button (at top of page, next to topic name)

Deleting a Source:
1. From the Home page, click on the topic that contains the source you wish to edit (will take you to the topic page)
2. Click on the "Delete Source" button for the source you want to edit (each source will have its own button)
    2a. You can also click on the "Source Details" button to go the source page, where you can also select to edit the source

Orphan Control:
1. Orphans are not allowed, and the control mechanism can be triggered in several ways:
    1a. Deleting a subject that contains any topics
    1b. Deleting a topic that contains any sources
    1c. Removing all topics when editing a subject
    1d. Removing all topics when editing a source
2. When triggered during deletion, you will be taken to a page to reassign any orphans to other subjects/topics before deletion will take place
3. When triggered during editing, your edits will not take place, instead the page will refresh with the existing info unchanged

### Sharing Sources Between Users
To Make Your Source Shareable
1. During creation or when editing, check the Public check box to expose your source to all users

When Sources Are Viewable by Others
1. All public sources that share a topic name will be viewable by all users who also have that topic
    1a. When matching topics, the topic name is case insensitive
2. Different users' sources that have the same URL are filtered out, so you won't see any duplicate sources
    2a. The "http://" and "www." are ignored during comparison
3. Other users' sources are displayed on the topic page below your sources

To Save Another User's Source
1. On the Topic page, scroll down below your sources to see other users' sources
2. Click on the "Save to Your Sources" button to add their source to your collection        
3. All the source info will be automatically added
4. The source will be assigned to the topic you viewed the source in
5. The added source will default to being private
6. The source will be yours and you'll have complete control over it like any other source
7. If you want to change any info, simply edit like any other source after saving
    7a. Any edits you make will not affect the original source
    7b. Any edits the original user makes will not affect your copy of the source    

### Editing Your Profile and Logging Out
Editing Your Profile:
1. Click on "Edit Profile" in the main navigation
2. A form pre-filled with current info will be displayed
3. Change whatever info you wish (same rules apply for creating a new profile - see above)
4. For security, your password will not be displayed
5. If you do NOT want to change your password, LEAVE THIS BLANK
    5a. If you do want to change your password, enter the new password into the field

Logging Out:
1. Click on "Logout" in the main navigation


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/marcon29/sinatra-sourcerer.git. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).


