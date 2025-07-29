# Development TODO list
Turn e621ng into a successor to Tarrgon's Reverser (which itself is one to Earlopain's)
copied and expanded from [github project](https://github.com/orgs/Catt0s-Projects/projects/1/views/2)
## Tag Importer
Import tags, aliases, implications, etc. from e621 on an ongoing basis, including the counts from e6.
- At 1AM UTC daily, get the new DB export and run a job to update everything
- Turn off "fix tag counts"
- import AIBURs as-is. No need to process them.
## Add e6 upload button
Add a button to upload a post to e621.
- Post field for direct URLs?
- Add buttons for copying description(s), in case it goes over the limit
  - description: replace brackets with unicode?
- Parent/Child items:
  - get sources and tags from them
  - earliest creation date => year tag
## e621 iqdb
check e621's iqdb for matches
- add a linkage on posts. 
  - Probably an object type
  - match item and match relation
- rate limiting
- md5 match: copy e6 tags and sources. Ensure e6 sources are up-to-date.
- Add metatags for searching these: 
  - File 
    - Type: better/same/unknown/(actual type) 
      - unknown being formats that support both lossless and lossy
    - Size: bigger/smaller/difference/(actual size)
  - Image
    - Resolution: bigger/smaller/same/(actual resolution)
    - Compression estimate: more/less/same/(actual number)
  - Match: MD5/'none'/(actual percentage match)
  - e621 status: active/deleted/(replaced?)
## Scraper tooling
Ensure third-party scraper can import items. Add tooling: 
- Pools: automatically scrape & pool items: 
  - items on the same post (ie, Pixiv, Twitter, etc.)
  - items linked from a post (for prev/next links)
- Parent: Parent/Child repurposed to be for "related" posts (iqdb matches)
  - Attempts to automatically determine "best" version, using res and compression estimate (no file type to avoid fake PNG throwing it off) 
- Rating: add a "none" rating. Does not need to be selectable in UI, as it is only used on initial upload.
- Scraper MD5 matches: Merge tags, sources, descriptions. 
  - Setting dates: Oldest post is the upload date. Each match adds changes as it's timestamp.
- Images: Store and present as AVIF? Discuss whether we even need to back up the original files
  - If a source no longer has the image, then wouldn't it be preferable to have a losslessly resaved JPG?
  - Unfortanately, e6 doesn't currently support AVIF, so it will need to be converted back for now...
- Add queue status page
- Sources: also add the artist URL scraped from.
- Site Tags: implimented in parallel with normal tags, but use their own DB index (?)
  - **alt idea**: use a new tag cateogry, and exclude them from upload? Might work better...
    - for project meta-tags (art, comms) prefix with `SPECIAL_`?
  - format as `{SITE_NAME}_{tag}`? may need adjustments to work.. 
    - tags attatched to posts but are not editable 
    - searchable like normal tags
  - maybes:
    - allow wiki for site tags (e6 tags link to e621 wiki directly)
    - allow AIBUR for site tags (needs to be seperate?)
- Set helpers - use sets to track: 
  - who added a url being scraped
  - user hides
- Fav helper: Use favorites as queue.
- Artist Pages: Implement artist pages as part of site tags
  - if the page starts with `-`, try using archive sites? 
    - furarchiver, etc. 
  - give commissioners artist pages too the same way
## Reverser Import
Add tooling to import data from reverser
- Images: 
  - Can we just point images to reverser's domain? ie, add a field for what bin an image is in? 
  - Script to import images automatically? 
    - Re-scrape missing stuff?
- Data: Talk to Tarrgon about getting from reverser:
  - deletions, etc => site tags
  - queue, hides => post sets 
  - artist listings => artist pages / site tags
  - iqdb matches to e6 => add post data for each
    - get post data from the db export instead of the api?
## Limit changes
Needs to change for proper functioning: 
- restrictions on tag names 
  - always, for site tags
  - on the initial db setup, for e621 tags
- rate limits
  - up the rate limit for sets, favs, changes, etc. 
  - RELATED: figure out a way to let users mass-edit posts more easily (site tags or e6 tags to many)
- size limits
  - up the limit on sets and fav sizes