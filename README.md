# RedRoverPhotos

Fetch and display mission photos from the Curiosity, Opportunity, and Spirit Mars rovers. 
This uses data from NASA's [Mars Rover Photos API](https://api.nasa.gov/?search=mars-rover-photos).

An API key is not required, but requests will be rate limited without one.
An API key can be obtained at the [NASA API Site](https://api.nasa.gov/).  If one is not provided, the DEMO_KEY will be used.
You can set your API Key by adding 

```
API_KEY=<your NASA key>
```
to the `.xcconfig` file for your Xcode scheme.