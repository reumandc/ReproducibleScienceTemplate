#A function needed for caching
mtime <- function(files)
{
  lapply(Sys.glob(files),function(x) X =   
           file.info(x)$mtime)
}