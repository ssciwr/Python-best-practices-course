# Code formatter
A code formatter takes care of formatting your code so that it adheres to the styling standards. For Python, a popular code formatter is [black](https://black.readthedocs.io/en/stable/) or also [Ruff](https://docs.astral.sh/ruff/formatter/). Black is PEP 8 compliant but also adds some [own flavor](https://black.readthedocs.io/en/stable/the_black_code_style/current_style.html) to the code. Comparing code that has been formatted with black makes it easier to spot the differences. You can even try it out [online](https://black.vercel.app/?version=stable&state=_Td6WFoAAATm1rRGAgAhARYAAAB0L-Wj4ARsAnNdAD2IimZxl1N_WlkPinBFoXIfdFTaTVkGVeHShArYj9yPlDvwBA7LhGo8BvRQqDilPtgsfdKl-ha7EFp0Ma6lY_06IceKiVsJ3BpoICJM9wU1VJLD7l3qd5xTmo78LqThf9uibGWcWCD16LBOn0JK8rhhx_Gf2ClySDJtvm7zQJ1Z-Ipmv9D7I_zhjztfi2UTVsJp7917XToHBm2EoNZqyE8homtGskFIiif5EZthHQvvOj8S2gJx8_t_UpWp1ScpIsD_Xq83LX-B956I_EBIeNoGwZZPFC5zAIoMeiaC1jU-sdOHVucLJM_x-jkzMvK8Utdfvp9MMvKyTfb_BZoe0-FAc2ZVlXEpwYgJVAGdCXv3lQT4bpTXyBwDrDVrUeJDivSSwOvT8tlnuMrXoD1Sk2NZB5SHyNmZsfyAEqLALbUnhkX8hbt5U2yNQRDf1LQhuUIOii6k6H9wnDNRnBiQHUfzKfW1CLiThnuVFjlCxQhJ60u67n3EK38XxHkQdOocJXpBNO51E4-f9z2hj0EDTu_ScuqOiC9cI8qJ4grSZIOnnQLv9WPvmCzx5zib3JacesIxMVvZNQiljq_gL7udm1yeXQjENOrBWbfBEkv1P4izWeAysoJgZUhtZFwKFdoCGt2TXe3xQ-wVZFS5KoMPhGFDZGPKzpK15caQOnWobOHLKaL8eFA-qI44qZrMQ7sSLn04bYeenNR2Vxz7hvK0lJhkgKrpVfUnZrtF-e-ubeeUCThWus4jZbKlFBe2Kroz90Elij_UZBMFCcFo0CfIx5mGlrINrTJLhERszRMMDd39XsBDzpZIYV4TcG7HoMS_IF8aMAAAxI-5uTWXbUQAAY8F7QgAAP01Vc6xxGf7AgAAAAAEWVo=).

Please note that the formatter reformats the file in-place, that means, substituting the content of the original file!

Note that the formatter does not reformat comments other than inserting proper whitespace before and after the #.

## Using the Ruff formatter

To invoke the Ruff formatter, use
```
ruff format
```
or 
```
ruff format --preview
```
similarly to the linter. 

You may also use `ruff check --fix`. This will not reformat all the code, but apply the fixes from linting that can be safely done.

## Ruff configuration
You can configure Ruff quite freely, and also use it to format docstrings and markdown files. Take a look [here](https://docs.astral.sh/ruff/formatter/#configuration) at some examples. You may also [configure your IDE](https://docs.astral.sh/ruff/editors/setup/) to lint and format your files using Ruff. It is also great for using in [`pre-commit hooks`](https://docs.astral.sh/ruff/integrations/#pre-commit).

**Task 3: GitHub assignment code formatter: Use the same repo as from Part 2 - Linter**

Format the code using `ruff format`. Check what it changes. See if you can get the autograding to pass.
