-- Python Language Server configurations
return {
  settings = {
    basedpyright = {
      analysis = {
        typeCheckingMode = 'basic',
        reportAbstractUsage = 'error',
        diagnosticMode = 'workspace',
        importFormat = 'relative',
      },
    },
  },
}
