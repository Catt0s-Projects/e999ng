
## e999 objects
### BaseFile
BaseFile objects provide a uniform API to get simple information about files. This includes: 
- file type
- width
- height
- md5
- animated: has multiple frames
- channel information:
  - alpha channel?
  - number of channels
    - the plan was to make this 1-indexed 1-4, but it may be better to check options for having more than 4. 
- color profile: has color profile
- consideration: lossy/lossless based on file header (jxl, webp, avif) and type (png, jpeg)
 
### Posts
Posts hold information about about a scraped item.

### remote_iqdb_match
object representing a match from the remote's iqdb

### 
