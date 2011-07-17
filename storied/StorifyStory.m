//
//  StorifyStory.m
//  storied
//
//  Created by Jonah Williams on 7/16/11.
//  Copyright 2011 Carbon Five. All rights reserved.
//

#import "StorifyStory.h"
#import "StorifyUser.h"
#import "StorifyElement.h"
#import "BlocksKit/BlocksKit.h"
#import "git2.h"

@implementation StorifyStory

@synthesize permalink = permalink_;
@synthesize published_at = published_at_;
@synthesize author = author_;
@synthesize editors = editors_;
@synthesize shorturl = shorturl_;
@synthesize title = title_;
@synthesize description = description_;
@synthesize thumbnail = thumbnail_;
@synthesize topics = topics_;
@synthesize elements = elements_;

- (id)initWithJSONDictionary:(NSDictionary *)jsonRepresentation {
    self = [super init];
    if (self) {
        NSMutableDictionary *jsonDictionary = [NSMutableDictionary dictionary];
        NSArray *jsonDictionaryKeys = [jsonRepresentation allKeys];
        for (id key in jsonDictionaryKeys) {
            if ([NSNull null] != [jsonRepresentation objectForKey:key]) {
                [jsonDictionary setObject:[jsonRepresentation objectForKey:key] forKey:key];
            }
        }
        
        self.permalink = [NSURL URLWithString:[jsonDictionary objectForKey:@"permalink"]];
        self.published_at = [NSDate dateWithTimeIntervalSince1970:[[jsonDictionary objectForKey:@"published_at"] doubleValue]];
        self.author = [[[StorifyUser alloc] initWithJSONDictionary:[jsonDictionary objectForKey:@"author"]] autorelease];
        self.shorturl = [NSURL URLWithString:[jsonDictionary objectForKey:@"shorturl"]];
        self.title = [jsonDictionary objectForKey:@"title"];
        self.description = [jsonDictionary objectForKey:@"description"];
        self.thumbnail = [NSURL URLWithString:[jsonDictionary objectForKey:@"thumbnail"]];
        self.topics = [jsonDictionary objectForKey:@"topics"];
        NSDictionary *elementsDictionary = [jsonDictionary objectForKey:@"elements"];
        NSUInteger elementCount = [[elementsDictionary allKeys] count];
        NSMutableArray *elements = [NSMutableArray arrayWithCapacity:elementCount];
        for (NSUInteger count = 0; count < elementCount; count++) {
            NSDictionary *elementDictionary = [elementsDictionary objectForKey:[[NSNumber numberWithUnsignedInteger:count] stringValue]];
            [elements addObject:[[[StorifyElement alloc] initWithJSONDictionary:elementDictionary] autorelease]];
        }
        self.elements = elements;
    }
    return self;
}

- (void)dealloc {
    [permalink_ release], permalink_ = nil;
    [published_at_ release], published_at_ = nil;
    [author_ release], author_ = nil;
    [editors_ release], editors_ = nil;
    [shorturl_ release], shorturl_ = nil;
    [title_ release], title_ = nil;
    [description_ release], description_ = nil;
    [thumbnail_ release], thumbnail_ = nil;
    [topics_ release], topics_ = nil;
    [elements_ release], elements_ = nil;
    [super dealloc];
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    if (self.permalink != nil) {    [dictionary setObject:[self.permalink absoluteString] forKey:@"permalink"];}
    if (self.published_at != nil) {    [dictionary setObject:[NSNumber numberWithDouble:[self.published_at timeIntervalSince1970]] forKey:@"published_at"];}
    [dictionary setObject:[self.author dictionaryRepresentation] forKey:@"author"];
    if (self.shorturl != nil) {[dictionary setObject:[self.shorturl absoluteString] forKey:@"shorturl"];}
    if (self.title != nil) {    [dictionary setObject:self.title forKey:@"title"];}
    if (self.description != nil) {    [dictionary setObject:self.description forKey:@"description"];}
    if (self.thumbnail != nil) {    [dictionary setObject:[self.thumbnail absoluteString] forKey:@"thumbnail"];}
    if (self.topics != nil) {    [dictionary setObject:self.topics forKey:@"topics"];}
    
    NSMutableDictionary *elementsDictionary = [NSMutableDictionary dictionaryWithCapacity:[self.elements count]];
    [self.elements enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [elementsDictionary setObject:[obj dictionaryRepresentation] forKey:[[NSNumber numberWithUnsignedInteger:idx] stringValue]];
    }];
    [dictionary setObject:elementsDictionary forKey:@"elements"];
    
    return dictionary;
}

- (NSString *)storagePath {
    //locate the directory for this story's repository
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *path = [documentsDirectory stringByAppendingPathComponent:[self.permalink path]];    
    return path;
}

+ (NSString *)repositoryPath {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}

+ (void)createStoryRepository {
    NSFileManager *fileManager = [NSFileManager defaultManager];

    //create a repository if necessary
    NSError *error;
    git_repository *repo;
    if (![fileManager fileExistsAtPath:[StorifyStory repositoryPath]]) {
        [fileManager createDirectoryAtPath:[StorifyStory repositoryPath] withIntermediateDirectories:YES attributes:nil error:&error];
    }
    if (![fileManager fileExistsAtPath:[[StorifyStory repositoryPath] stringByAppendingPathComponent:@".git"]]) {
        NSLog(@"Creating git repository in %@", [StorifyStory repositoryPath]);
        git_repository_init(&repo, [[StorifyStory repositoryPath] UTF8String], 0);
        [fileManager createFileAtPath:[[StorifyStory repositoryPath] stringByAppendingPathComponent:@"readme.md"] contents:[@"A storify story" dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
        [self commitFileAtPath:@"readme.md" inRepositoryAtPath:[StorifyStory repositoryPath]];
        git_repository_free(repo);
    }
}

- (void)saveStoryHistory {
    NSMutableDictionary *jsonRepresentation = [NSMutableDictionary dictionaryWithDictionary:[self dictionaryRepresentation]];
    [jsonRepresentation writeToFile:[[self storagePath] stringByAppendingPathComponent:@"story.plist"] atomically:YES];
    [StorifyStory commitFileAtPath:[[self.permalink path] stringByAppendingPathComponent:@"story.plist"] inRepositoryAtPath:[[StorifyStory repositoryPath] stringByAppendingPathComponent:@".git"]];
}

- (void)saveStory {
    NSMutableDictionary *jsonRepresentation = [NSMutableDictionary dictionaryWithDictionary:[self dictionaryRepresentation]];
    [jsonRepresentation writeToFile:[[self storagePath] stringByAppendingPathComponent:@"story.plist"] atomically:YES];
    [StorifyStory commitFileAtPath:[[self.permalink path] stringByAppendingPathComponent:@"story.plist"] inRepositoryAtPath:[[StorifyStory repositoryPath] stringByAppendingPathComponent:@".git"]];
}

+ (void)commitFileAtPath:(NSString *)relativeFilePath inRepositoryAtPath:(NSString *)pathToGitDir {    
    git_repository *repo;
    git_index *index;
    git_signature *author= git_signature_now("username", "storied@storify.example");
    
    git_repository_open(&repo, [pathToGitDir UTF8String]);
    
    //add the file to the index
    git_repository_index(&index, repo);
    git_index_read(index);   
    git_index_add(index, [relativeFilePath UTF8String], 0);
    git_index_write(index);
    
    //write the current index to a tree on disk
    git_oid indexTreeOID;
    git_tree_create_fromindex(&indexTreeOID, index);
    git_tree *indexTree;
    git_tree_lookup(&indexTree, repo, &indexTreeOID);
    
    //look for a reference to master
    git_reference *masterBranchReference;
    int result = git_reference_lookup(&masterBranchReference, repo, "refs/heads/master");
    git_oid *commitOID = NULL;
    if (result != 0) {
        //for a new repository without a master branch, create a new branch
        git_commit_create(commitOID, repo, NULL, author, author, "updated story", indexTree, 0, NULL);
        git_reference_create_oid(&masterBranchReference, repo, "refs/heads/master", commitOID, 0);
        git_reference *headReference;
        git_reference_create_symbolic(&headReference, repo, "HEAD", "refs/heads/master", 0);
    } 
    else {
        //for a repository with an existing master branch get the parent commit
        git_commit *parent;
        const git_oid *parentOID = git_reference_oid(masterBranchReference);
        git_commit_lookup(&parent, repo, parentOID);
        const git_commit *parents[] = {parent};
        git_commit_create(commitOID, repo, "HEAD", author, author, "updated story again", indexTree, 1, parents);
    }
    
    git_signature_free(author);
    git_index_free(index);
    git_repository_free(repo);
}

@end
