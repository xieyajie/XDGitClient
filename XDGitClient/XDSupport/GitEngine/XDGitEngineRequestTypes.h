//
//  XDGitEngineRequestTypes.h
//  XDGitClient
//
//  Created by xieyajie on 14-2-18.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

typedef enum XDGitRequestType 
{
    XDGitFetchUserToken = -1,						// fetch token
	XDGitUsersRequest = 0,						// Get more than one non-specific user
	XDGitUserRequest,							// Get exactly one specific user
    XDGitUserEditRequest,                        // Edit the authenticated user
    XDGitEmailsRequest,                          // Get one or more email addresses
    XDGitEmailAddRequest,                        // Add one or more email addresses
    XDGitEmailDeleteRequest,                     // Delete one or more email addresses
	XDGitRepositoriesRequest,					// Get more than one non-specific repository
	XDGitRepositoryRequest,						// Get exactly one specific repository
	XDGitRepositoryUpdateRequest,				// Update repository metadata
    XDGitRepositoryWatchingRequest,              // Auth'd user watching a specific repository?
	XDGitRepositoryWatchRequest,					// Watch a repository
	XDGitRepositoryUnwatchRequest,				// Unwatch a repository
    XDGitRepositoryForksRequest,                 // Get one or more forks
	XDGitRepositoryForkRequest,					// Fork a repository,
	XDGitRepositoryCreateRequest,				// Create a repository
	XDGitRepositoryPrivatiseRequest,				// Make a repository private
	XDGitRepositoryPubliciseRequest,				// Make a repository public
	XDGitRepositoryDeleteRequest,				// Delete a repository
	XDGitRepositoryDeleteConfirmationRequest,	// Confirm deletion of a repository
	XDGitDeployKeysRequest,						// Get repository-specific deploy keys
    XDGitDeployKeyRequest,                       // Get exactly one specific deploy key
	XDGitDeployKeyAddRequest,					// Add a repository-specific deploy key
    XDGitDeployKeyEditRequest,                   // Edit a deploy key
	XDGitDeployKeyDeleteRequest,					// Delete a repository-specific deploy key
	XDGitRepositoryLanguageBreakdownRequest,		// Get the language breakdown for a repository
    XDGitRepositoryContributorsRequest,          // Get one or more contributors
    XDGitRepositoryTeamsRequest,                 // Get one or more teams
	XDGitTagsRequest,							// Tags for a repository
	XDGitBranchesRequest,						// Branches for a repository
	XDGitCollaboratorsRequest,					// Collaborators for a repository
	XDGitCollaboratorAddRequest,					// Add a collaborator
	XDGitCollaboratorRemoveRequest,				// Remove a collaborator
    XDGitDownloadsRequest,                       // Get one or more downloads
    XDGitDownloadRequest,                        // Get exactly one specific download
    XDGitDownloadAddRequest,                     // Add a download
    XDGitDownloadDeleteRequest,                  // Delete a download
    XDGitRepositoryHooksRequest,                 // Get one or more repository hooks
    XDGitRepositoryHookRequest,                  // Get one specific repository hook
    XDGitRepositoryHookAddRequest,               // Add a repository hook
    XDGitRepositoryHookEditRequest,              // Edit a repository hook
    XDGitRepositoryHookTestRequest,              // Test a repository hook
    XDGitRepositoryHookDeleteRequest,            // Delete a repository hook
	XDGitCommitsRequest,							// Get more than one non-specific commit
	XDGitCommitRequest,							// Get exactly one specific commit
    XDGitCommitCommentsRequest,                  // Get one or more commit comments
    XDGitCommitCommentRequest,                   // Get exactly one commit comment
    XDGitCommitCommentAddRequest,                // Add a commit comment
    XDGitCommitCommentEditRequest,               // Edit a commit comment
    XDGitCommitCommentDeleteRequest,             // Delete a commit comment
	XDGitIssuesOpenRequest,						// Get open issues
	XDGitIssuesClosedRequest,					// Get closed issues
    XDGitIssuesRequest,                          // Get all issues
	XDGitIssueRequest,							// Get exactly one specific issue
	XDGitIssueAddRequest,						// Add an issue
	XDGitIssueEditRequest,						// Edit an issue
	XDGitIssueCloseRequest,						// Close an issue
	XDGitIssueReopenRequest,						// Reopen a closed issue
    XDGitIssueDeleteRequest,                     // Delete an issue
	XDGitRepositoryLabelsRequest,				// Get repository-wide issue labels
	XDGitRepositoryLabelAddRequest,				// Add a repository-wide issue label
    XDGitRepositoryLabelEditRequest,             // Edit a repository-wide issue label
	XDGitRepositoryLabelRemoveRequest,			// Remove a repository-wide issue label
    XDGitIssueLabelsRequest,                     // Get one or more issue labels
    XDGitIssueLabelRequest,                      // Get exactly one specific issue label
	XDGitIssueLabelAddRequest,					// Add a label to a specific issue
	XDGitIssueLabelRemoveRequest,				// Remove a label from a specific issue
    XDGitIssueLabelReplaceRequest,               // Replace all labels on a specific issue
	XDGitIssueCommentsRequest,					// Get more than one non-specific issue comment
	XDGitIssueCommentRequest,					// Get exactly one specific issue comment
	XDGitIssueCommentAddRequest,					// Add a comment to an issue
    XDGitIssueCommentEditRequest,                // Edit an issue comment
    XDGitIssueCommentDeleteRequest,              // Delete an issue comment
    XDGitFollowingRequest,                       // Following 
    XDGitFollowersRequest,                       // Followers
    XDGitFollowRequest,                          // Follow a User
    XDGitUnfollowRequest,                        // Unfollow a user
    XDGitMilestonesRequest,                      // Get one or more milestones
    XDGitMilestoneRequest,                       // Get exactly one specific milestone
    XDGitMilestoneCreateRequest,                 // Create a new milestone
    XDGitMilestoneUpdateRequest,                 // Edit an existing milestone
    XDGitMilestoneDeleteRequest,                 // Delete a milestone
    XDGitPublicKeysRequest,                      // Get one or more public keys
    XDGitPublicKeyRequest,                       // Get exactly one public key
    XDGitPublicKeyAddRequest,                    // Add a public key
    XDGitPublicKeyEditRequest,                   // Edit a public key
    XDGitPublicKeyDeleteRequest,                 // Delete a public key
	XDGitTreeRequest,							// Get the listing of a tree by SHA
    XDGitTreeCreateRequest,                      // Create a new tree
	XDGitBlobsRequest,							// Get the names and SHAs of all blobs for a specific tree SHA
	XDGitBlobRequest,							// Get data about a single blob by tree SHA and path
    XDGitBlobCreateRequest,                      // Create a new blob
	XDGitRawBlobRequest,							// Get the raw data for a blob
    XDGitReferencesRequest,                      // Get one or more references
    XDGitReferenceRequest,                       // Get exactly one reference
    XDGitReferenceCreateRequest,                 // Create a new reference
    XDGitReferenceUpdateRequest,                 // Edit an existing reference
    XDGitTagObjectRequest,                       // Get exactly one annotated tag object
    XDGitTagObjectCreateRequest,                 // Create a new annotated tag object
    XDGitRawCommitRequest,                       // Get exactly one raw commit
    XDGitRawCommitCreateRequest,                 // Create a new raw commit
    XDGitGistsRequest,                           // Get one or more gists
    XDGitGistRequest,                            // Get exactly one gist
    XDGitGistCreateRequest,                      // Create a new gist
    XDGitGistUpdateRequest,                      // Edit a gist
    XDGitGistStarRequest,                        // Star a gist
    XDGitGistUnstarRequest,                      // Unstar a gist
    XDGitGistStarStatusRequest,                  // Get star status of a gist
    XDGitGistForkRequest,                        // Fork a gist
    XDGitGistDeleteRequest,                      // Delete a gist
    XDGitGistCommentsRequest,                    // Get one or more gist comments
    XDGitGistCommentRequest,                     // Get exactly one gist comment
    XDGitGistCommentCreateRequest,               // Create a new gist comment
    XDGitGistCommentUpdateRequest,               // Edit a gist comment
    XDGitGistCommentDeleteRequest,               // Delete a gist comment
    XDGitNotificationsRequest,                   // List all notifications for the current user, grouped by repository
    XDGitNotificationsMarkReadRequest,           // Mark a notification as read
    XDGitNotificationsMarkThreadReadRequest,     // Mark a notification thread as read
    XDGitNotificationThreadSubscriptionRequest,  // Subscribe or unsubscribe from a notification thread
    XDGitNotificationDeleteSubscriptionRequest,  // Delete a notification thread subscription
    XDGitIssueEventsRequest,                     // Get one or more issue events
    XDGitIssueEventRequest,                           // Get exactly one issue event
    XDGitPullRequestsRequest,                    // Get one or more pull requests
    XDGitPullRequestRequest,                     // Get exactly one pull request
    XDGitPullRequestCreateRequest,               // Create a pull request
    XDGitPullRequestUpdateRequest,               // Edit a pull request
    XDGitPullRequestCommitsRequest,              // Get commits in a pull request
    XDGitPullRequestFilesRequest,                // Get files in a pull request
    XDGitPullRequestMergeStatusRequest,          // Get the merge status of a pull request
    XDGitPullRequestMergeRequest,                // Merge a pull request
    XDGitPullRequestCommentsRequest,             // Get one or more pull request comments
    XDGitPullRequestCommentRequest,              // Get exactly one pull request comments
    XDGitPullRequestCommentCreateRequest,        // Create a pull request comment
    XDGitPullRequestCommentUpdateRequest,        // Update a pull request comment
    XDGitPullRequestCommentDeleteRequest,        // Delete a pull request comment
    XDGitEventsRequest,                          // Get one or more events of unspecified type
    XDGitOrganizationsRequest,                   // Get one or more organizations
    XDGitOrganizationRequest,                    // Get exactly one organization
    XDGitOrganizationUpdateRequest,              // Update an existing organization
    XDGitOrganizationMembersRequest,             // Get one or more organization members
    XDGitOrganizationMembershipStatusRequest,    // Get whether user is member of a specified organization
    XDGitOrganizationMemberRemoveRequest,        // Remove a user from am organization
    XDGitOrganizationMembershipPublicizeRequest, // Publicize user's membership of organization
    XDGitOrganizationMembershipConcealRequest,   // Concel user's membership of organization
    XDGitTeamsRequest,                           // Get one or more organization teams
    XDGitTeamRequest,                            // Get exactly one organization team
    XDGitTeamCreateRequest,                      // Create a new team
    XDGitTeamUpdateRequest,                      // Update an existing team
    XDGitTeamDeleteRequest,                      // Delete an existing team
    XDGitTeamMembersRequest,                     // Get one or more team members
    XDGitTeamMembershipStatusRequest,
    XDGitTeamMemberAddRequest,
    XDGitTeamMemberRemoveRequest,                // Remove a user from a team
    XDGitTeamRepositoryManagershipStatusRequest, // Get whether a team manages a specific repository
    XDGitTeamRepositoryManagershipAddRequest,    // Add a specific repository to a team
    XDGitTeamRepositoryManagershipRemoveRequest, // Remove a specific repository from a team
    XDGitAssigneesRequest,                       // Get one or more assignees
    XDGitAssigneeRequest,                        // Get whether one user is an assignee on a repository
    XDGitMarkdownRequest,                        // Get a string as Markdown
    XDGitRepositoryMergeRequest,                 // Merge one branch into another
} XDGitRequestType;


typedef enum XDGitResponseType 
{
    XDGitNoContentResponse = 0,                  // No content expected
	XDGitUsersResponse,                          // One or more users
	XDGitUserResponse,							// Exactly one user
    XDGitEmailsResponse,                         // One or more email addresses
	XDGitRepositoriesResponse,					// One or more repositories 
	XDGitRepositoryResponse,						// Exactly one repository
    XDGitRepositoryTeamsResponse,                // One or more teams
    XDGitDeployKeysResponse,                     // One or more deploy keys
    XDGitDeployKeyResponse,                      // Exactly one deploy key
    XDGitDownloadsResponse,                      // One or more downloads
    XDGitDownloadResponse,                       // Exactly one download
	XDGitRepositoryLanguageBreakdownResponse,	// Breakdown in language-bytes pairs
	XDGitBranchesResponse,						// One or more branches
	XDGitCollaboratorsResponse,					// One or more users
    XDGitRepositoryHooksResponse,                // One or more repository hooks
    XDGitRepositoryHookResponse,                 // Exactly one repository hook
	XDGitCommitsResponse,						// One or more commits
	XDGitCommitResponse,							// Exactly one commit
    XDGitCommitCommentsResponse,                 // One or more commit comments
    XDGitCommitCommentResponse,                  // Exactly one commit comment
	XDGitIssuesResponse,							// One or more issues
	XDGitIssueResponse,							// Exactly one issue
	XDGitIssueCommentsResponse,					// One or more issue comments
	XDGitIssueCommentResponse,					// Exactly one issue comment
	XDGitIssueLabelsResponse,					// One or more issue labels
    XDGitIssueLabelResponse,                     // Exactly one issue label
	XDGitRepositoryLabelsResponse,				// One or more repository-wide issue labels
    XDGitRepositoryLabelResponse,                // Exactly one repository-wide issue label
	XDGitBlobsResponse,							// Name and SHA for all files in given tree SHA
	XDGitBlobResponse,							// Metadata and file data for given tree SHA and path 
    XDGitFollowingResponse,                      // Following
    XDGitFollowersResponse,                      // Followers  
    XDGitFollowedResponse,                       // User was followed
    XDGitUnfollowedResponse,                     // User was unfollowed
    XDGitMilestonesResponse,                     // One or more milestones
    XDGitMilestoneResponse,                      // Exactly one milestone
    XDGitPublicKeysResponse,                     // One or more public keys
    XDGitPublicKeyResponse,                      // Exactly one public key
    XDGitSHAResponse,                            // SHA
	XDGitTreeResponse,							// Metadata for all files in given commit
    XDGitReferencesResponse,                     // One or more references
    XDGitReferenceResponse,                      // Exactly one reference
    XDGitAnnotatedTagsResponse,                  // One or more annotated tag objects
    XDGitAnnotatedTagResponse,                   // Exactly one annotated tag object
    XDGitRawCommitResponse,                      // Exactly one raw commit
    XDGitGistsResponse,                          // One or more gists
    XDGitGistResponse,                           // Exactly one gist
    XDGitGistCommentsResponse,                   // One or more gist comments
    XDGitGistCommentResponse,                    // Exactly one gist comment
    XDGitIssueEventsResponse,                    // One or more issue events
    XDGitIssueEventResponse,                     // Exactly one issue event
    XDGitPullRequestsResponse,                   // One or more pull requests
    XDGitPullRequestResponse,                    // Exactly one pull request
    XDGitPullRequestMergeSuccessStatusResponse,  // Success or failure of merge attempt
    XDGitPullRequestCommitsResponse,             // One or more pull request commits
    XDGitPullRequestFilesResponse,               // One or more pull request files
    XDGitPullRequestCommentsResponse,            // One or more pull request comments
    XDGitPullRequestCommentResponse,             // Exactly one pull request comment
    XDGitTagsResponse,							// Tags in name-SHA pairs
    XDGitNotificationsResponse,                  // One or more notifications
    XDGitNotificationThreadsResponse,            // One or more notification threads
    XDGitNotificationThreadSubscriptionResponse, // Exactly one notification thread subscription
    XDGitEventsResponse,                         // One or more events of unspecified type
    XDGitOrganizationsResponse,                  // One or more organizations
    XDGitOrganizationResponse,                   // Exactly one organization
    XDGitTeamsResponse,                          // One or more organization teams
    XDGitTeamResponse,                           // Exactly one team
    XDGitMarkdownResponse,                       // HTML from Markdown
} XDGitResponseType;
