# Development TODO list
Turn e621ng into a successor to Tarrgon's Reverser (which itself is one to Earlopain's)
## Tag Importer
Import tags, aliases, implications, etc. from e621 on an ongoing basis, including the counts from e6.
- At 1AM UTC daily, get the new DB export and run a job to update everything
  - `https://e621.net/db_export/` -> files for db exports, `.csv.gz`
    - https://github.com/mm12/cat621/blob/tagging-import/db/populate.rb#L154
    - https://github.com/mm12/cat621/blob/tagging-import/db/populate.rb#L105
- disable "fix tag counts" button. We want the db's tag count for e621 tags to be wrong.
- import AIBURs as-is. No need to process them - just use the current status and add them into the database. 
## Add e621 upload button
Add a button to upload a post to e621.
- Post field for direct URLs?
- Add buttons for copying description(s), in case it goes over the limit
  - description: replace brackets with unicode to prevent dtext formatting issues (eg, `[section=abc[]]` would replace the inner brackets)
  - same for tags? Add a copy button. 
  - both of these will need to also look at the child posts to correctly format it
- Parent/Child items:
  - get sources and tags from them
  - earliest creation date => year tag
## e621 iqdb
check e621's iqdb for matches
- add a linkage on posts. 
  - Probably an object type
  - match item and match relation
- rate limiting
- md5 match: copy e621 tags and sources. Ensure e621 sources are up-to-date.
### Add metatags for searching these: 
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
### Ensure third-party scraper can import items. 
- Try to get imgbrd-grabber working
  - works with danbooru, but may need modding to work with e621ng
- Try adding other importers for things unsupported by it
  - eg, furarchiver archives, mega and proton folders
  - Ask Tarrgon for Discord scraper integration help
### Add tooling: 
- Pools: automatically scrape & pool items: 
  - items on the same post (ie, Pixiv, Twitter, etc.)
  - items linked from a post (for prev/next links)
- Parent: Parent/Child repurposed from e621 usage to be for "related" posts (iqdb matches). All posts with a strong match are added as a child. 
  - Attempts to automatically determine "best" version, using res and compression estimate (no file type to avoid fake PNG throwing it off) 
- Rating: add a "none" rating. Does not need to be selectable in UI, as it is only used on initial upload.
- Scraper MD5 matches: Merge tags, sources, descriptions. 
  - Setting dates: Oldest post is the upload date. Each match adds changes as it's timestamp.
- Images: Store and present as AVIF? Discuss whether we even need to back up the original files
  - ie, convert all the images to AVIF. Smaller file size, lossless, and very flexible. But there are drawbacks...
  - Unfortunately, e621ng doesn't currently support AVIF. This will need to be added.
  - If an image's original file url from source no longer exists, then the AVIF will be the only option. 
    - This means we will need to convert it to another format, essentially "re-saving", which we are usually against. 
    - Is this an acceptable tradeoff for the circumstances?
- Add queue status page
  - Internal IQDB status - how many items are queued to add/update/check iqdb for
  - e621 IQDB status - how many items are queued to check e621's iqdb for matches there are
  - Scraper status - what URLs the scraper is busy with 
- Sources: also add the artist URL scraped from.
- Fav helper: Use favorites as a user's "todo" queue
### Site Tags: 
implemented in parallel with normal tags, but use their own DB index (?)
  - **alt idea**: use a new tag category, and exclude them from upload? Might work better...
    - for project meta-tags (art, comms) prefix with `SPECIAL_`?
  - format as `{SITE_NAME}_{tag}`? may need adjustments to work.. 
    - tags attached to posts but are not editable 
    - searchable like normal tags
  - maybes:
    - allow wiki for site tags (e621 tags link to e621 wiki directly)
    - allow AIBURs for site tags (needs to be separate?)
- Set helpers - use sets to track: 
  - who added a url being scraped
  - user hides
### Artist Pages: Implement artist pages as part of site tags instead of normal tags
  - URLs & names are already part of them, so can be added automatically. 
    - add a property for scrape info? (status, percentages, last scraped)
  - Cross-reference who added URLs in the changelog to add to a set of URLs added by that user
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
  - iqdb matches to e621 => add post data for each
    - get post data from the db export instead of the api?
## Limit changes
Needs to change for proper functioning: 
- restrictions on tag names 
  - always, for site tags
  - on the initial db setup, for e621 tags
- rate limits
  - up the rate limit for sets, favs, changes, etc. 
  - RELATED: figure out a way to let users mass-edit posts more easily (site tags or e621 tags to many)
- size limits
  - up the limit on sets and fav sizes