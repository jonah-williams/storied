//
//  StorifyUserTest.m
//  storied
//
//  Created by Jonah Williams on 7/16/11.
//  Copyright 2011 Carbon Five. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
//#import "OCMock.h"
#import "JSONKit.h"
#import "StorifyUser.h"

@interface StorifyUserTest : SenTestCase

@end


@implementation StorifyUserTest

- (void)setUp {
  
}

- (void)tearDown {
  
}

- (void)testInitWithJSONDictionary {
    NSString *rawJSON = @"{\"metadata\":{\"profile_background_image_url\":\"http://s.twimg.com/a/1277919661/images/themes/theme1/bg.png\",\"description\":\"Webentrepreneur/developer.Founderof@listimonkey,@publitweet,@europatweets\",\"location\":\"SanFrancisco\",\"profile_sidebar_fill_color\":\"e0ff92\",\"status\":{\"in_reply_to_screen_name\":null,\"truncated\":false,\"retweeted_status\":{\"in_reply_to_screen_name\":null,\"truncated\":false,\"in_reply_to_status_id\":null,\"source\":\"API\",\"created_at\":\"SatJul0321:00:05+00002010\",\"favorited\":false,\"contributors\":null,\"in_reply_to_user_id\":null,\"geo\":null,\"place\":null,\"id\":{\"low_\":496897296,\"high_\":4},\"coordinates\":null,\"text\":\"DropboxAPIisavailablehttp://bit.ly/baiP4R\"},\"in_reply_to_status_id\":null,\"source\":\"TwitterforiPhone\",\"created_at\":\"SatJul0321:26:44+00002010\",\"favorited\":false,\"contributors\":null,\"in_reply_to_user_id\":null,\"geo\":null,\"place\":null,\"id\":{\"low_\":498076183,\"high_\":4},\"coordinates\":null,\"text\":\"RT@newsycombinator:DropboxAPIisavailablehttp://bit.ly/baiP4R\"},\"profile_background_tile\":false,\"statuses_count\":8599,\"profile_sidebar_border_color\":\"87bc44\",\"lang\":\"en\",\"profile_use_background_image\":true,\"created_at\":\"SunDec1021:40:41+00002006\",\"followers_count\":1350,\"profile_image_url\":\"http://a1.twimg.com/profile_images/16158822/xavier2_normal.jpg\",\"contributors_enabled\":false,\"friends_count\":315,\"geo_enabled\":true,\"profile_background_color\":\"9ae4e8\",\"screen_name\":\"xdamman\",\"following\":false,\"favourites_count\":863,\"protected\":false,\"verified\":false,\"profile_text_color\":\"000000\",\"name\":\"XavierDamman\",\"notifications\":false,\"time_zone\":\"PacificTime(US&Canada)\",\"url\":\"http://www.xavierdamman.be/blog\",\"id\":55993,\"utc_offset\":-28800,\"profile_link_color\":\"0000ff\"},\"created_at\":\"2010-07-04T03:58:15.630Z\",\"updated_at\":1286087612,\"last_login\":1286087612,\"userid\":\"55993\",\"username\":\"xdamman\",\"description\":\"Webentrepreneur/developer.Founderof@listimonkey,@publitweet,@europatweets\",\"location\":\"SanFrancisco\",\"_id\":\"4c3006d742ae830121000001\",\"name\":\"XavierDamman\",\"avatar\":\"http://a1.twimg.com/profile_images/16158822/xavier2_normal.jpg\",\"website\":\"http://www.xavierdamman.be/blog\",\"permalink\":\"http://storify.com/xdamman\"}";
    
    NSError *error = nil;
    NSDictionary *jsonDictionary = [rawJSON objectFromJSONStringWithParseOptions:JKParseOptionNone error:&error];
    STAssertNil(error, @"test should use valid JSON: %@", error);
    StorifyUser *user = [[[StorifyUser alloc] initWithJSONDictionary:jsonDictionary] autorelease];
    STAssertNotNil(user.username, @"user username should not be nil");
    STAssertNotNil(user.name, @"user name should not be nil");
    STAssertNotNil(user.avatar, @"user avatar should not be nil");
    STAssertNotNil(user.description, @"user description should not be nil");
    STAssertNotNil(user.location, @"user location should not be nil");
    STAssertNotNil(user.website, @"user website should not be nil");
    STAssertNotNil(user.permalink, @"user permalink should not be nil");
}
@end