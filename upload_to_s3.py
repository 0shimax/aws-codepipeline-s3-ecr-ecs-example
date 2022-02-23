from typing import Dict
import os
import zipfile
import boto3

def upload_sources_for_codepipeline_to_s3(onnx_model, s3_parameters: Dict) -> None:
    s3 = boto3.client(
        "s3",
        aws_access_key_id=os.environ["AccessKeyId"],
        aws_secret_access_key=os.environ["SecretAccessKey"],
        aws_session_token=os.environ["SessionToken"],
    )

    with open(f"/tmp/{s3_parameters['model_file_name']}", "wb") as f:
        f.write(onnx_model.SerializeToString())

    with zipfile.ZipFile(
        f"/tmp/{s3_parameters['codepipeline_source_dir_name']}.zip", "w"
    ) as f:
        f.write(
            f"/tmp/{s3_parameters['model_file_name']}",
            arcname=f"{s3_parameters['codepipeline_source_dir_name']}/{s3_parameters['model_file_name']}",
        )
        f.write(
            "./prediction_server_cpp/Dockerfile",
            arcname=f"{s3_parameters['codepipeline_source_dir_name']}/Dockerfile",
        )
        f.write(
            "./prediction_server_cpp/server_sync",
            arcname=f"{s3_parameters['codepipeline_source_dir_name']}/server_sync",
        )
        f.write(
            "./prediction_server_cpp/buildspec.yml",
            arcname=f"{s3_parameters['codepipeline_source_dir_name']}/buildspec.yml",
        )

    s3.upload_file(
        f"/tmp/{s3_parameters['codepipeline_source_dir_name']}.zip",
        s3_parameters["bucket_name"],
        s3_parameters["key"] + f"/{s3_parameters['codepipeline_source_dir_name']}.zip",
    )
