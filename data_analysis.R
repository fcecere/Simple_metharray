library("ChAMP")

#WD
setwd("/media/francesco/dati/MethArray/Training_array")

#Parameters
metharray <- "450K"
norm <- "BMIQ"
testDir <- "/media/francesco/dati/MethArray/Training_array"

#in the testDir there will be all the idat files and the Samplesheet.csv that you will create with all the informations about your samples
#Columns required: Sample_Name - Sample_Group - Sentrix_ID - Sentrix_Position

#Load our data
myLoad <- champ.load(testDir,
                     method="ChAMP",
                     methValue="B",
                     autoimpute=TRUE,
                     filterDetP=TRUE,
                     ProbeCutoff=0,
                     SampleCutoff=0.1,
                     detPcut=0.01,
                     filterBeads=TRUE,
                     beadCutoff=0.05,
                     filterNoCG=TRUE,
                     filterSNPs=TRUE,
                     population=NULL,
                     filterMultiHit=TRUE,
                     filterXY=TRUE,
                     force=FALSE,
                     arraytype=metharray)

#check the quality
champ.QC()

#Normalization process
myNorm <- champ.norm(beta=myLoad$beta,
                     arraytype=metharray, 
                     method=norm,
                     plotBMIQ = TRUE,
                     cores = 8)

#check the quality of normalized data
champ.QC(beta = myNorm)

#Calculate the DMRs with Bumphunter
myDMR <- champ.DMR(beta=myNorm,pheno=myLoad$pd$Sample_Group,method="Bumphunter")

#check DMRs
DMR.GUI()
