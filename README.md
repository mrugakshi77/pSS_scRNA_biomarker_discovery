# pSS scRNA-seq Biomarker Discovery

Reproducing and extending findings from [Hong et al.](https://doi.org/10.1038/s41467-021-26888-3) on cytotoxic CD4⁺ T cell expansion and immune dysregulation in **Primary Sjögren's Syndrome (pSS)** using publicly available single-cell RNA-seq data.

**By [Mrugakshi Chidrawar](https://mrugakshi77.github.io/) — Bioinformatician | M.S. Bioinformatics, Boston University**  
[![LinkedIn](https://img.shields.io/badge/LinkedIn-mrugakshi--chidrawar-blue?logo=linkedin)](https://www.linkedin.com/in/mrugakshi-chidrawar-827127179/)
[![Live App](https://img.shields.io/badge/Shiny-Live%20App-brightgreen?logo=r)](https://mrugakshi77.shinyapps.io/pss-biomarker-explorer/)

---

## Overview

Primary Sjögren's Syndrome is a systemic autoimmune disease characterised by immune cell infiltration of exocrine glands. This project analyses ~58,000 peripheral blood immune cells from 5 pSS patients and 5 healthy controls (GEO: [GSE157278](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE157278)) to confirm published findings and identify cluster-specific biomarker expression patterns.

---

## Analysis Pipeline

| Step | Method |
|------|--------|
| Data download | GEOquery |
| Quality control | nFeature_RNA 200–2500, percent.mt < 20% |
| Normalisation | LogNormalize (scale factor 10,000) |
| Feature selection | Top 2,000 highly variable genes (VST) |
| Dimensionality reduction | PCA (30 PCs) → UMAP |
| Clustering | Louvain (resolution 0.5) → 27 clusters |
| Differential expression | FindMarkers — pSS vs Healthy Control |

---

## Key Findings

- **HLA-DRB5** was the top upregulated gene (~4× higher in pSS)
- **GZMA** and **GZMB** were among the strongest differentially expressed genes, confirming cytotoxic CD4⁺ T cell expansion consistent with Hong et al.
- Clear UMAP separation between pSS and healthy samples with no obvious batch effects, supporting a strong biological signal
- 990 differentially expressed genes identified (logFC > 0.25, min.pct > 0.25, adj. p < 0.05)

---

## Interactive Shiny App

An interactive dashboard for exploring the results without re-running the analysis.

🔗 **[Live App → mrugakshi77.shinyapps.io/pss-biomarker-explorer](https://mrugakshi77.shinyapps.io/pss-biomarker-explorer/)**

**Features:**
- UMAP coloured by cluster, disease status, or sample batch
- Any gene's expression overlaid on the UMAP in real time (2,000 HVGs)
- Volcano plot and filterable biomarker table
- Heatmaps of top statistically significant biomarkers (adj. p < 0.05) by disease status and cluster
- Violin, dot, and gene–gene scatter plots for custom gene sets

**Technical note:** The app runs without loading the full Seurat object at runtime. Expression data is stored as a sparse matrix (`dgCMatrix`), reducing memory from ~4GB to under 200MB — keeping it deployable on the free tier of shinyapps.io.

---

## Repository Structure

```
├── pss_workflow.ipynb        # Full analysis pipeline (R kernel)
├── prepare_app_data.R        # Extracts lightweight data from Seurat object
├── app.R                     # R Shiny dashboard
└── README.md
```

---

## Tools & Skills

`R` · `Seurat` · `ggplot2` · `pheatmap` · `R Shiny` · `Matrix (sparse)` · `GEOquery` · `Jupyter` · `Single-cell RNA-seq` · `Biomarker discovery`

---

## Reference

Hong, T. et al. (2021). Identification of cytotoxic CD4⁺ T cell population in primary Sjögren's syndrome. *Nature Communications*, 12, 6525. https://doi.org/10.1038/s41467-021-26888-3
