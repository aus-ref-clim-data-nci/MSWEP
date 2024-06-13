# MSWEP

## Overview

We have replicated the monthly, daily, and 3hourly Multi-Source Weighted-Ensemble Precipitation (mswep) data from GloH2O.

MSWEP is a global precipitation product with a 0.1° resolution available from 1979 - 2020. The product is unique in that it merges gauge, satellite, and reanalysis data to obtain the highest quality precipitation estimates at every location. MSWEP incorporates daily gauge observations and accounts for gauge reporting times to reduce temporal mismatches between satellite-reanalysis estimates and gauge observations. MSWEP is compatible with GloH2O’s operational Multi-Source Weather (MSWX); MSWX forecasts can thus be used to extend MSWEP into the future. MSWEP tends to exhibit better performance than other precipitation products in both densely gauged and ungauged regions (see [Beck et al., 2017](https://hess.copernicus.org/articles/21/6201/2017/), and [Beck et al., 2019](https://hess.copernicus.org/articles/23/207/2019/)).

This is an extract of the dataset description from the [website](https://www.gloh2o.org/)
where you can find more information on this data. We replicated only the historical precipitation data, if the realtime data is required then please open a new issue in  https://github.com/aus-ref-clim-data-nci/mswep/issues

## Data download

The data is downloaded from a google drive hosted by https://www.gloh2o.org. The data is monthly, daily, and 3hourly historical data from 1979 - 2020.

The script uses rclone, to run: 

```bash
bash mswep.sh -f <freq>.
```

Where `<freq>` is mon, day, or 3hr.

The code used to concatenate the files is a bash script calling CDO:

```bash
bash mswep_concat.sh -f <freq>
```

**Note:** rclone was used to download this data from Google Drive. This required me to add the MSWEP shared folder to my Drive and link rclone to my Drive account. If more up-to-date MSWEP data is released in the future then the user running the download script needs to add the shared folder and [link rclone](https://www.youtube.com/watch?v=vPs9K_VC-lg).

## Data location

We've downloaded the MSWEP netCDF data to:
```
/g/data/ia39/aus-ref-clim-data-nci/mswep/data/<freq>/mswep_v280_<freq>_<year>.nc
```

Where `<freq>` is mon, day, or 3hr; `<year>` is a year in the range 1979 - 2020. The Monthly, Daily, and 3Hourly data have been concatenated into yearly files. 


## License

Data is freely available but there are restrictions on commercial use, please see their [website](https://www.gloh2o.org/).

"MSWEP is released under the Creative Commons Attribution-NonCommercial 4.0 International (CC BY-NC 4.0) license. Please [contact us](https://www.gloh2o.org/contact/) if you are affiliated with a commercial entity and want to trial MSWEP. If you do not have a commercial affiliation and you intend to use the product for non-commercial purposes, please send us a [request](https://www.gloh2o.org/) by clicking "APLY HERE" under the "Data license" section. You will receive a link to the Google Drive containing MSWEP once your request has been approved. "

## Data citation
No citation has been provided on their [website](https://www.gloh2o.org/).

## References

Beck, H. E., Wood, E. F., Pan, M., Fisher, C. K., Miralles, D. M., van Dijk, A. I. J. M., McVicar, T. R., and Adler, R. F. MSWEP V2 global 3‑hourly 0.1° precipitation: methodology and quantitative assessment Bulletin of the American Meteorological Society 100(3), 473–500, 2019

## Acknowledgement

ECMWF, NASA, and NOAA and thanked for producing the ERA5, IMERG, and GridSat datasets, respectively. The Water Center for Arid and Semi-Arid Zones in Latin America and the Caribbean (CAZALAC) and the Centro de Ciencia del Clima y la Resiliencia (CR) 2 (FONDAP 15110009) are thanked for sharing Mexican and Chilean gauge data, respectively. We also acknowledge the gauge data providers in the Latin American Climate Assessment and Dataset (LACA&D) project: IDEAM (Colombia), INAMEH (Venezuela), INAMHI (Ecuador), SENAMHI (Peru), SENAMHI (Bolivia), and DMC (Chile). We wish to thank Ali Alijanian, Koen Verbist, and Piyush Jain for providing additional gauge data. 

## Assistance

For assistance with GHCN data on NCI,
open a new issue at https://github.com/aus-ref-clim-data-nci/mswep/issues
