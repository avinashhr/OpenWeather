//
//  OWConstants.h
//  Weather
//
//  Created by Ramesh, Avinash on 4/19/17.
//  Copyright © 2017 Ramesh, Avinash. All rights reserved.
//

#ifndef OWConstants_h
#define OWConstants_h

//urls
#define baseURL @"http://api.openweathermap.org/"
#define weatherByCityName @"data/2.5/weather"
#define weatherConditionIcon @"img/w"

//error code

#define noDataErrorCode 111
#define noNetworkErrorCode 440
#define successCode 0

//error message

#define noDataErrorMessage @"No results to show. Please try with a different city."
#define noNetworkErrorMessage @"Couldn't reach server. Please try again."
#define defaultErrorMessage @"The operation couldn’t be completed."
#define errorDomian @"OWErrorDefault"

#endif /* OWConstants_h */
