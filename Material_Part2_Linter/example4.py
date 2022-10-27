
map_expressions = {
    "KAT1MoralisierendesSegment": "KAT1-Moralisierendes Segment",
    "Moralwerte": "KAT2-Moralwerte",
    "KAT2Subjektive_Ausdrcke": "KAT2-Subjektive Ausdrücke",
    "Protagonistinnen2": "KAT3-Gruppe",
    "Protagonistinnen": "KAT3-Rolle",
    "Protagonistinnen3": "KAT3-own/other",
    "KommunikativeFunktion": "KAT4-Kommunikative Funktion",
    "Forderung": "KAT5-Forderung explizit",
    "KAT5Ausformulierung": "KAT5-Forderung implizit",
    "Kommentar": "KOMMENTAR",
}

def validate_data_dict(data_dict):
    if not data_dict:
        raise ValueError("data_dict is empty")
    for data_file_name, data_file in data_dict.items():
        validation_list = ["data", "file_type", "sofa", "paragraph"]
        missing_cats = []
        for category in validation_list:
            if category not in list(data_file.keys()):
                missing_cats.append(category)

        if missing_cats:
            raise ValueError(f"Data dict is missing categories: {missing_cats}")


class AnalyseOccurrence:
    """Contains statistical information methods about the data."""

    def __init__(
        self,
        data_dict: dict,
        mode: str = "instances",
        file_names: str = None,
    ) -> None:

        validate_data_dict(data_dict)

        self.mode = mode
        self.data_dict = data_dict
        self.mode_dict = {
            "instances": self.report_instances,
            "spans": self.report_spans,
            "span_index": self.report_index,
        }
        self.file_names = self._initialize_files(file_names)
        self.instance_dict = self._initialize_dict()
        # call the analysis method
        self.mode_dict[self.mode]()
        # map the df columns to the expressions given
        self.map_categories()

    def _initialize_files(self, file_names: str) -> list:
        """Helper method to get file names in list."""
        # get the file names from the global dict of dicts
        if file_names is None:
            file_names = list(self.data_dict.keys())
        # or use the file names that were passed explicitly
        elif isinstance(file_names, str):
            file_names = [file_names]
        return file_names

    def _initialize_dict(self) -> defaultdict:
        """Helper method to initialize dict."""
        return defaultdict(lambda: defaultdict(lambda: defaultdict(int)))

    def _initialize_df(self):
        """Helper method to initialize data frame."""
        self.df = pd.DataFrame(self.instance_dict)
        self.df.index = self.df.index.set_names((["Main Category", "Sub Category"]))

    def _get_categories(self, span_dict, file_name):
        """Helper method to initialize a dict with the given main and sub categories."""
        for main_cat_key, main_cat_value in span_dict.items():
            for sub_cat_key, sub_cat_value in main_cat_value.items():
                # the tuple index makes it easy to convert the dict into a pandas dataframe
                self.instance_dict[file_name][(main_cat_key, sub_cat_key)] = len(
                    sub_cat_value
                )
        return self.instance_dict

    def _add_total(self):
        """Helper method to set additional headers in data frame."""
        self.df.loc[("total instances", "with invalid"), :] = self.df.sum(axis=0).values
        self.df.loc[("total instances", "without invalid"), :] = (
            self.df.loc[("total instances", "with invalid"), :].values
            - self.df.loc["KAT1MoralisierendesSegment", "Keine Moralisierung"].values
        )

    def _clean_df(self):
        """Helper method to sort data frame and clean up values."""
        self.df = self.df.sort_values(
            by=[
                "Main Category",
                "Sub Category",
                # self.file_names[0],
            ],
            ascending=True,
        )
        # fill NaN with 0 for instances or None for spans
        if self.mode == "instances":
            self.df = self.df.fillna(0)
        if self.mode == "spans":
            self.df = self.df.replace({np.nan: None})
            # remove quotes - not sure if this is necessary
            # self.df = self.df.applymap(lambda x: x.replace('"','') if isinstance(x, str) else x)

    def report_instances(self):
        """Reports number of occurrences of a category per text source."""
        # instances reports the number of occurrences
        # filename: main_cat: sub_cat: instances
        for file_name in self.file_names:
            span_dict = self.data_dict[file_name]["data"]
            # initilize total instances rows for easier setting later.
            # only for mode instances
            self.instance_dict[file_name][("total instances", "with invalid")] = 0
            self.instance_dict[file_name][("total instances", "without invalid")] = 0
            self.instance_dict = self._get_categories(span_dict, file_name)
        # initialize data frame
        self._initialize_df()
        # add rows for total instances
        # only do this for mode instances
        self._add_total()

    def report_spans(self):
        """Reports spans of a category per text source."""
        # span reports the spans of the annotations separated by separator-token
        self.instance_dict = self._get_categories(
            self.data_dict[self.file_names[0]]["data"], self.file_names[0]
        )
        self._initialize_df()
        self.df[:] = self.df[:].astype("object")
        for file_name in self.file_names:
            span_dict = self.data_dict[file_name]["data"]
            span_text = self.data_dict[file_name]["sofa"]
            for main_cat_key, main_cat_value in span_dict.items():
                for sub_cat_key in main_cat_value.keys():
                    # save the span begin and end character index for further analysis
                    # span_dict[main_cat_key][sub_cat_key] =
                    # find the text for each span
                    span_annotated_text = [
                        span_text[span["begin"] : span["end"]]
                        for span in span_dict[main_cat_key][sub_cat_key]
                    ]
                    # clean the spans from #
                    span_annotated_text = [
                        span.replace("#", "") for span in span_annotated_text
                    ]
                    # clean the spans from "
                    # span_annotated_text = [
                    #     span.replace('"', "") for span in span_annotated_text
                    # ]
                    # convert list to &-separated spans
                    span_annotated_text = " & ".join(span_annotated_text)
                    self.df.at[
                        (main_cat_key, sub_cat_key),
                        file_name,
                    ] = span_annotated_text

    def report_index(self):
        self.report_instances()
        self.df[:] = self.df[:].astype("object")
        for file_name in self.file_names:
            span_dict = self.data_dict[file_name]["data"]
            for main_cat_key, main_cat_value in span_dict.items():
                for sub_cat_key in main_cat_value.keys():
                    # report the beginning and end of each span as a tuple
                    span_list = [
                        (span["begin"], span["end"])
                        for span in span_dict[main_cat_key][sub_cat_key]
                    ]
                    self.df.at[
                        (main_cat_key, sub_cat_key),
                        file_name,
                    ] = span_list

    def map_categories(self):
        self.df = self.df.rename(map_expressions)
        self._clean_df()



