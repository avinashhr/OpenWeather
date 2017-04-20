//
//  OWWeatherByCityNameViewController.m
//  Weather
//
//  Created by Ramesh, Avinash on 4/20/17.
//  Copyright © 2017 Ramesh, Avinash. All rights reserved.
//

#import "OWWeatherByCityNameViewController.h"
#import "OWServiceWrapper.h"
#import "OWStatus.h"
#import "OWConstants.h"
#import "OWDataManager.h"

@interface OWWeatherByCityNameViewController ()

@property (nonatomic, strong) OWServiceWrapper *serviceWrapper;
@property (weak, nonatomic) IBOutlet UILabel *cityNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *currentConditionLbl;
@property (weak, nonatomic) IBOutlet UILabel *currentTempLbl;
@property (weak, nonatomic) IBOutlet UIImageView *currentConditionIconImgView;
@property (weak, nonatomic) IBOutlet UISearchBar *weatherSearchBar;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (weak, nonatomic) IBOutlet UILabel *sunriseTimeLbl;
@property (weak, nonatomic) IBOutlet UILabel *sunsetTimeLbl;

@property (weak, nonatomic) IBOutlet UILabel *humidityLbl;
@property (weak, nonatomic) IBOutlet UILabel *windValueLbl;
@property (weak, nonatomic) IBOutlet UILabel *pressureValueLbl;
@property (weak, nonatomic) IBOutlet UILabel *visibilityValueLbl;

@end

@implementation OWWeatherByCityNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self stopSpinner];
    // Do any additional setup after loading the view, typically from a nib.
    [self initialize];
    [self.weatherSearchBar setBackgroundColor:[UIColor clearColor]];
    [self.weatherSearchBar setBackgroundImage:[UIImage new]];
    [self.weatherSearchBar setTranslucent:YES];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// initialize data and UI
- (void) initialize {
    
    self.serviceWrapper = [[OWServiceWrapper alloc] init];
    NSString *recentSearch = [[NSUserDefaults standardUserDefaults] objectForKey:@"recentCitySearched"];

    if (recentSearch.length > 0) {
        [self getWeatherForCity:recentSearch];
    } else {
        [self hideLabels:YES];

    }

}


- (void)showSpinner {
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [self.spinner setHidden:false];
    [self.spinner startAnimating];
}

- (void)stopSpinner {
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    [self.spinner setHidden:true];
    [self.spinner stopAnimating];
}

- (void)showResponseWithStatus:(OWStatus *)status {
    
    [self stopSpinner];
    
    // if no error, process the response else display alert with error
    if(status.statusCode == successCode) {
        [self reloadData];
        
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:status.statusMessage preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction
                                       actionWithTitle:@"Ok"
                                       style:UIAlertActionStyleCancel
                                       handler:^(UIAlertAction *action)
                                       {
                                           
                                       }];
        
        [alert addAction: cancelAction];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    
}

// load UI with data from server
- (void)reloadData {
    [self hideLabels:NO];
    OWWeather *currentWeather = [[OWDataManager sharedDataManager] getCurrentWeatherOfSearchedCity];
    self.cityNameLbl.text = currentWeather.cityName;
    self.currentConditionLbl.text = currentWeather.weatherDescription;
    self.currentTempLbl.text = [NSString stringWithFormat:@"%ld°",lround(currentWeather.temprature)];
    self.sunriseTimeLbl.text = [self stringWithKey:@"Sunrise" andValue:currentWeather.sunRiseTime];
    self.sunsetTimeLbl.text = [self stringWithKey:@"Sunset" andValue:currentWeather.sunSetTime];
    
    self.humidityLbl.text = [self stringWithKey:@"Humidity" andValue:[NSString stringWithFormat:@"%ld%%",lround(currentWeather.humidity)]];
    self.windValueLbl.text = [self stringWithKey:@"Wind" andValue:[NSString stringWithFormat:@"%ld mph",lround(currentWeather.windSpeed)]];
    self.pressureValueLbl.text = [self stringWithKey:@"Pressure" andValue:[NSString stringWithFormat:@"%ld hPa",lround(currentWeather.pressure)]];
    self.visibilityValueLbl.text= [self stringWithKey:@"Visibility" andValue:[NSString stringWithFormat:@"%ld mi",currentWeather.visibility]];

    [self.serviceWrapper getWeatherIconWithId:currentWeather.iconID andCompletionBlock:^(UIImage *image) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.currentConditionIconImgView.image = image;
        });
    }];
    
}

- (NSString *)stringWithKey:(NSString *)key andValue:(NSString *)value {
    return [NSString stringWithFormat:@"%@: %@",key, value];
}

- (void)hideLabels:(BOOL)hide {
    // to hide all the labels when loaded initiall without any data
    [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        // do not hide searc bar, activity indicator and navigation bar
        if (![obj isKindOfClass:[UISearchBar class]] && ![obj isKindOfClass:[UIActivityIndicatorView class]] && ![obj isKindOfClass:[UINavigationBar class]]) {
            obj.hidden = hide;
        }
        
        }];
}

// make the service call to get weather data for searched city
- (void)getWeatherForCity:(NSString *)city{
    [self showSpinner];
    // hardcoding country to US and units to Imperial, also not using state, given time I would cretae mapping between city, state and country using city List from Open Weather and give an option to user to select units
    [self.serviceWrapper retrieveCurrentWeatherForCity:city ofCountry:@"US" inUnits:@"Imperial" withCompletionBlock:^(OWStatus *status) {
        // dispatch in main queue, as UI update needs main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showResponseWithStatus:status];
        });
    }];

}
#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    
    [[NSUserDefaults standardUserDefaults] setObject:searchBar.text forKey:@"recentCitySearched"];
    [self getWeatherForCity:searchBar.text];
}

@end
