def validate_data_dict(data_dict):
    if not data_dict:
        raise ValueError("data_dict is empty")
    for something, otherthing in data_dict.items():
        if not otherthing:
            raise ValueError(f"The dict content under {something} is empty.")
        if not isinstance(otherthing, dict):
            raise ValueError(
                f"The content of {something} is not a dict but {type(otherthing)}."
            )

        list = ["data", "file_type", "sofa", "paragraph"]
        missing_cats = []
        for category in list:
            if category not in list(otherthing.keys()):
                missing_cats.append(category)

        if missing_cats:
            raise ValueError(f"Data dict is missing categories: {missing_cats}")


if __name__ == "__main__":
    data_dict = {}
    data_dict = {"test": {"testing": "just testing"}}
    validate_data_dict(data_dict)