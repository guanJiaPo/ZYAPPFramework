//
//  ZYSystem.m
//  ZYAPPFramework
//
//  Created by szy on 2019/1/31.
//  Copyright © 2019 szy. All rights reserved.
//

#import "ZYSystem.h"
#include <sys/socket.h>
#include <sys/sysctl.h>
#include <net/if.h>
#import <net/if_dl.h>
#import <AdSupport/AdSupport.h>
#import <sys/utsname.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>
#import <ifaddrs.h>
#import <resolv.h>
#import <arpa/inet.h>
#import <netdb.h>
#import <netinet/ip.h>
#import <net/ethernet.h>
#import <Photos/Photos.h>

#define MDNS_PORT       5353
#define QUERY_NAME      "_apple-mobdev2._tcp.local"
#define DUMMY_MAC_ADDR  @"02:00:00:00:00:00"
#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
#define IOS_VPN         @"utun0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"

@implementation ZYSystem

/// app版本(appstore展示的版本号)
+ (NSString *)appVersion {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

/// app build版本
- (NSString *)appBuildVersion {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
}

/// 系统版本
+ (NSString *)systemVersion {
    return [[UIDevice currentDevice] systemVersion];
}

/// 手机型号
+ (NSString *)currentDevice {
    struct utsname systemInfo;
    uname(&systemInfo); // 获取系统设备信息
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    
    NSDictionary *dict = @{
                           // iPhone
                           @"iPhone5,3" : @"iPhone 5c",
                           @"iPhone5,4" : @"iPhone 5c",
                           @"iPhone6,1" : @"iPhone 5s",
                           @"iPhone6,2" : @"iPhone 5s",
                           @"iPhone7,1" : @"iPhone 6 Plus",
                           @"iPhone7,2" : @"iPhone 6",
                           @"iPhone8,1" : @"iPhone 6s",
                           @"iPhone8,2" : @"iPhone 6s Plus",
                           @"iPhone8,4" : @"iPhone SE",
                           @"iPhone9,1" : @"iPhone 7",
                           @"iPhone9,2" : @"iPhone 7 Plus",
                           @"iPhone10,1" : @"iPhone 8",
                           @"iPhone10,4" : @"iPhone 8",
                           @"iPhone10,2" : @"iPhone 8 Plus",
                           @"iPhone10,5" : @"iPhone 8 Plus",
                           @"iPhone10,3" : @"iPhone X",
                           @"iPhone10,6" : @"iPhone X",
                           @"iPhone11,2" : @"iPhone XS",
                           @"iPhone11,4" : @"iPhone XS Max",
                           @"iPhone11,6" : @"iPhone XS Max",
                           @"iPhone11,8" : @"iPhone XR",
                           @"i386" : @"iPhone Simulator",
                           @"x86_64" : @"iPhone Simulator",
                           // iPad
                           @"iPad4,1" : @"iPad Air",
                           @"iPad4,2" : @"iPad Air",
                           @"iPad4,3" : @"iPad Air",
                           @"iPad5,3" : @"iPad Air 2",
                           @"iPad5,4" : @"iPad Air 2",
                           @"iPad6,7" : @"iPad Pro 12.9",
                           @"iPad6,8" : @"iPad Pro 12.9",
                           @"iPad6,3" : @"iPad Pro 9.7",
                           @"iPad6,4" : @"iPad Pro 9.7",
                           @"iPad6,11" : @"iPad 5",
                           @"iPad6,12" : @"iPad 5",
                           @"iPad7,1" : @"iPad Pro 12.9 inch 2nd gen",
                           @"iPad7,2" : @"iPad Pro 12.9 inch 2nd gen",
                           @"iPad7,3" : @"iPad Pro 10.5",
                           @"iPad7,4" : @"iPad Pro 10.5",
                           @"iPad7,5" : @"iPad 6",
                           @"iPad7,6" : @"iPad 6",
                           // iPad mini
                           @"iPad2,5" : @"iPad mini",
                           @"iPad2,6" : @"iPad mini",
                           @"iPad2,7" : @"iPad mini",
                           @"iPad4,4" : @"iPad mini 2",
                           @"iPad4,5" : @"iPad mini 2",
                           @"iPad4,6" : @"iPad mini 2",
                           @"iPad4,7" : @"iPad mini 3",
                           @"iPad4,8" : @"iPad mini 3",
                           @"iPad4,9" : @"iPad mini 3",
                           @"iPad5,1" : @"iPad mini 4",
                           @"iPad5,2" : @"iPad mini 4",
                           // Apple Watch
                           @"Watch1,1" : @"Apple Watch",
                           @"Watch1,2" : @"Apple Watch",
                           @"Watch2,6" : @"Apple Watch Series 1",
                           @"Watch2,7" : @"Apple Watch Series 1",
                           @"Watch2,3" : @"Apple Watch Series 2",
                           @"Watch2,4" : @"Apple Watch Series 2",
                           @"Watch3,1" : @"Apple Watch Series 3",
                           @"Watch3,2" : @"Apple Watch Series 3",
                           @"Watch3,3" : @"Apple Watch Series 3",
                           @"Watch3,4" : @"Apple Watch Series 3",
                           @"Watch4,1" : @"Apple Watch Series 4",
                           @"Watch4,2" : @"Apple Watch Series 4",
                           @"Watch4,3" : @"Apple Watch Series 4",
                           @"Watch4,4" : @"Apple Watch Series 4"
                           };
    NSString *name = dict[platform];
    return name ? name : platform;
}

/// bundle id
+ (NSString *)bundleIdentifier {
    
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
}

/// 系统名称
+ (NSString *)systemName {
    return [[UIDevice currentDevice] systemName];
}

/// 手机品牌规则：手机型号_系统版本##手机品牌(iPhone 6 plus_9.3.2##iPhone)
+ (NSString *)pbrand {
    return [NSString stringWithFormat:@"%@_%@##%@",[self systemName],[[UIDevice currentDevice] systemVersion],[self currentDevice]];
}

/// iOS 8 以上是否开启通知
+ (BOOL)isAllowedRemoteNotification {
    UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
    if (UIUserNotificationTypeNone != setting.types) {
        return YES;
    }
    return NO;
}

/// 获取设备当前网络IP地址
+ (NSString *)getIPAddress:(BOOL)preferIPv4 {
    NSArray *searchArray = preferIPv4 ?
    @[ IOS_VPN @"/" IP_ADDR_IPv4, IOS_VPN @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6 ] :
    @[ IOS_VPN @"/" IP_ADDR_IPv6, IOS_VPN @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4 ] ;
    
    NSDictionary *addresses = [self getIPAddr];
    
    __block NSString *address;
    [searchArray enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL * _Nonnull stop) {
        address = addresses[key];
        //筛选出IP地址格式
        if([self isValidatIP:address]) *stop = YES;
    }];
    return address ? address : @"0.0.0.0";
}

+ (BOOL)isValidatIP:(NSString *)ipAddress {
    if (ipAddress.length == 0) {
        return NO;
    }
    NSString *urlRegEx = @"^([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])$";
    
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:urlRegEx options:0 error:&error];
    
    if (regex != nil) {
        NSTextCheckingResult *firstMatch=[regex firstMatchInString:ipAddress options:0 range:NSMakeRange(0, [ipAddress length])];
        return firstMatch;
    }
    return NO;
}

+ (NSDictionary *)getIPAddr {
    NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];
    
    // retrieve the current interfaces - returns 0 on success
    struct ifaddrs *interfaces;
    if(!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        struct ifaddrs *interface;
        for(interface=interfaces; interface; interface=interface->ifa_next) {
            if(!(interface->ifa_flags & IFF_UP) /* || (interface->ifa_flags & IFF_LOOPBACK) */ ) {
                continue; // deeply nested code harder to read
            }
            const struct sockaddr_in *addr = (const struct sockaddr_in*)interface->ifa_addr;
            char addrBuf[ MAX(INET_ADDRSTRLEN, INET6_ADDRSTRLEN) ];
            if(addr && (addr->sin_family==AF_INET || addr->sin_family==AF_INET6)) {
                NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
                NSString *type;
                if(addr->sin_family == AF_INET) {
                    if(inet_ntop(AF_INET, &addr->sin_addr, addrBuf, INET_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv4;
                    }
                } else {
                    const struct sockaddr_in6 *addr6 = (const struct sockaddr_in6*)interface->ifa_addr;
                    if(inet_ntop(AF_INET6, &addr6->sin6_addr, addrBuf, INET6_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv6;
                    }
                }
                if(type) {
                    NSString *key = [NSString stringWithFormat:@"%@/%@", name, type];
                    addresses[key] = [NSString stringWithUTF8String:addrBuf];
                }
            }
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    return [addresses count] ? addresses : nil;
}

/// 获取设备mac物理地址(比较耗时)
+ (NSString *)getMacAddress {
#if TARGET_IPHONE_SIMULATOR
    return nil;
#else
    res_9_init();
    int len;
    //get currnet ip address
    NSString *ip = [self currentIPAddressOf:IOS_WIFI];
    if(ip == nil) {
        fprintf(stderr, "could not get current IP address of en0\n");
        return DUMMY_MAC_ADDR;
    }//end if
    
    //set port and destination
    _res.nsaddr_list[0].sin_family = AF_INET;
    _res.nsaddr_list[0].sin_port = htons(MDNS_PORT);
    _res.nsaddr_list[0].sin_addr.s_addr = [self IPv4Pton:ip];
    _res.nscount = 1;
    
    unsigned char response[NS_PACKETSZ];
    
    
    //send mdns query
    if((len = res_9_query(QUERY_NAME, ns_c_in, ns_t_ptr, response, sizeof(response))) < 0) {
        
        fprintf(stderr, "res_search(): %s\n", hstrerror(h_errno));
        return DUMMY_MAC_ADDR;
    }//end if
    
    //parse mdns message
    ns_msg handle;
    if(ns_initparse(response, len, &handle) < 0) {
        fprintf(stderr, "ns_initparse(): %s\n", hstrerror(h_errno));
        return DUMMY_MAC_ADDR;
    }//end if
    
    //get answer length
    len = ns_msg_count(handle, ns_s_an);
    if(len < 0) {
        fprintf(stderr, "ns_msg_count return zero\n");
        return DUMMY_MAC_ADDR;
    }//end if
    
    //try to get mac address from data
    NSString *macAddress = nil;
    for(int i = 0 ; i < len ; i++) {
        ns_rr rr;
        ns_parserr(&handle, ns_s_an, 0, &rr);
        
        if(ns_rr_class(rr) == ns_c_in &&
           ns_rr_type(rr) == ns_t_ptr &&
           !strcmp(ns_rr_name(rr), QUERY_NAME)) {
            char *ptr = (char *)(ns_rr_rdata(rr) + 1);
            int l = (int)strcspn(ptr, "@");
            
            char *tmp = calloc(l + 1, sizeof(char));
            if(!tmp) {
                perror("calloc()");
                continue;
            }//end if
            memcpy(tmp, ptr, l);
            macAddress = [NSString stringWithUTF8String:tmp];
            free(tmp);
        }//end if
    }//end for each
    macAddress = macAddress ? macAddress : DUMMY_MAC_ADDR;
    return macAddress;
    #endif
}//end getMacAddressFromMDNS

/// 设备物理地址（随机生成）
+ (NSString *)macArcAddress {

    int mib[6];
    size_t len;
    char *buf;
    unsigned char *ptr;
    struct if_msghdr *ifm;
    struct sockaddr_dl *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        free(buf);
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *MACAddress = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                            *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    
    return MACAddress;
}

+ (nonnull NSString *)currentIPAddressOf: (nonnull NSString *)device {
    struct ifaddrs *addrs;
    NSString *ipAddress = nil;
    
    if(getifaddrs(&addrs) != 0) {
        return nil;
    }//end if
    
    //get ipv4 address
    for(struct ifaddrs *addr = addrs ; addr ; addr = addr->ifa_next) {
        if(!strcmp(addr->ifa_name, [device UTF8String])) {
            if(addr->ifa_addr) {
                struct sockaddr_in *in_addr = (struct sockaddr_in *)addr->ifa_addr;
                if(in_addr->sin_family == AF_INET) {
                    ipAddress = [self IPv4Ntop:in_addr->sin_addr.s_addr];
                    break;
                }//end if
            }//end if
        }//end if
    }//end for
    
    freeifaddrs(addrs);
    return ipAddress;
}//end currentIPAddressOf:

+ (nullable NSString *)IPv4Ntop: (in_addr_t)addr {
    char buffer[INET_ADDRSTRLEN] = {0};
    return inet_ntop(AF_INET, &addr, buffer, sizeof(buffer)) ?
    [NSString stringWithUTF8String:buffer] : nil;
}//end IPv4Ntop:

+ (in_addr_t)IPv4Pton: (nonnull NSString *)IPAddr {
    in_addr_t network = INADDR_NONE;
    return inet_pton(AF_INET, [IPAddr UTF8String], &network) == 1 ?
    network : INADDR_NONE;
}//end IPv4Pton:

/// idfv (uuid)
+ (NSString *)idfvString {
    
    return [[UIDevice currentDevice].identifierForVendor UUIDString];;
}


#pragma mark - 系统权限获取

/// 相机权限
+ (BOOL)cameraAccessAuthorized {
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [self showTip:@"该设备不支持拍照"];
        return NO;
    }
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied) {
        [self showTip:@"请在iPhone的“设置->隐私->相机”中打开本应用的访问权限"];
        return NO;
    } else {
        return YES;
    }
}

/// 照片(相册)权限
+ (BOOL)photoLibraryAccessAuthorized {
    PHAuthorizationStatus status = PHPhotoLibrary.authorizationStatus;
    if (status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusDenied) {
        [self showTip:@"请在iPhone的“设置->隐私->照片”中打开本应用的访问权限"];
        return NO;
    }
    return YES;
}

/// 发短信权限
+ (BOOL)canSendSMS {
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"sms://"]];
}

/// 打电话权限
+ (BOOL)canMakePhoneCall {
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tel://"]];
}

/// 调用打电话功能（此种方法会直接进行拨打电话,电话结束后会留在电话界面）
+ (void)openTelphone:(NSString *)phone {
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phone]]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phone]]];
    }
}

/// 调用打电话功能（此种方法会询问是否拨打电话,电话结束后会返回到应用界面,但是有上架App Store被拒的案例）
+ (void)openTelpromptPhone:(NSString *)phone {
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",phone]]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",phone]]];
    }
}

/// 调用发短信功能（此种方法会直接跳转到给指定号码发送短信,短信结束后会留在短信界面）
+ (void)openSendSMSWithPhone:(NSString *)phone {
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:[NSString stringWithFormat:@"sms://%@",phone]]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"sms://%@",phone]]];
    }
}

/// 跳转到定位服务
+ (void)openLocationService {
    if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:UIApplicationLaunchOptionsLocationKey]]) {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:UIApplicationLaunchOptionsLocationKey]];
    }
}

/*********************** 沙盒路径 **********************/

+ (NSURL *)documentsURL {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

+ (NSString *)documentsPath {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
}

+ (NSURL *)cachesURL {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask] lastObject];
}

+ (NSString *)cachesPath {
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
}

+ (NSURL *)libraryURL {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSLibraryDirectory inDomains:NSUserDomainMask] lastObject];
}

+ (NSString *)libraryPath {
    return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
}

@end
