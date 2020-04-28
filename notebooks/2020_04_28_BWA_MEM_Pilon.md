### BWA

* 'bwa' needs an indexed file
* 'bwa' outputs a '.sam' file but we need a '.bam' and '.bai' files for 'pilon'
* use 'samtools' for sorting and indexing (the conversion is done automatically with 'samtools sort')

### Pilon

