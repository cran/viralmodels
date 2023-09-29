# viraltab() works

    Code
      print(viraltab(x, semilla, target, pliegues, repeticiones, rejilla))
    Output
                          wflow_id              .config .metric   mean std_err n
      1            normalized_MARS Preprocessor1_Model1    rmse 191.14   10.86 2
      2            normalized_MARS Preprocessor1_Model1     rsq   0.46    0.08 2
      3                simple_MARS Preprocessor1_Model1    rmse 191.14   10.86 2
      4                simple_MARS Preprocessor1_Model1     rsq   0.46    0.08 2
      5  normalized_neural_network Preprocessor1_Model1    rmse 227.01   48.46 2
      6  normalized_neural_network Preprocessor1_Model1     rsq   0.26    0.13 2
      7      simple_neural_network Preprocessor1_Model1    rmse 241.93   57.78 2
      8      simple_neural_network Preprocessor1_Model1     rsq   0.32    0.27 2
      9            full_quad_svm_r Preprocessor1_Model1    rmse 243.65    2.32 2
      10           full_quad_svm_r Preprocessor1_Model1     rsq   0.27    0.01 2
      11              simple_svm_r Preprocessor1_Model1    rmse 243.65    2.32 2
      12              simple_svm_r Preprocessor1_Model1     rsq   0.55    0.03 2
      13          normalized_svm_r Preprocessor1_Model1    rmse 243.65    2.32 2
      14          normalized_svm_r Preprocessor1_Model1     rsq   0.55    0.03 2
      15            full_quad_MARS Preprocessor1_Model1    rmse 254.28   78.51 2
      16            full_quad_MARS Preprocessor1_Model1     rsq   0.34    0.15 2
      17  full_quad_neural_network Preprocessor1_Model1    rmse 503.87  317.21 2
      18  full_quad_neural_network Preprocessor1_Model1     rsq   0.17    0.16 2
               preprocessor   model rank
      1              recipe    mars    1
      2              recipe    mars    1
      3  workflow_variables    mars    2
      4  workflow_variables    mars    2
      5              recipe     mlp    3
      6              recipe     mlp    3
      7  workflow_variables     mlp    4
      8  workflow_variables     mlp    4
      9              recipe svm_rbf    5
      10             recipe svm_rbf    5
      11 workflow_variables svm_rbf    6
      12 workflow_variables svm_rbf    6
      13             recipe svm_rbf    7
      14             recipe svm_rbf    7
      15             recipe    mars    8
      16             recipe    mars    8
      17             recipe     mlp    9
      18             recipe     mlp    9

