import { S3Client, PutObjectCommand } from "@aws-sdk/client-s3";

const s3 = new S3Client({});

export const handler = async (event) => {
  try {
    // API Gateway envía body como string
    const body = JSON.parse(event.body);

    if (!body.file) {
      return {
        statusCode: 400,
        body: JSON.stringify({ error: "No file provided" })
      };
    }

    // convertir base64 a buffer
    const buffer = Buffer.from(body.file, "base64");

    const fileName = `image-${Date.now()}.png`;

    await s3.send(new PutObjectCommand({
      Bucket: process.env.BUCKET,
      Key: `uploads/${fileName}`,
      Body: buffer,
      ContentType: "image/png"
    }));

    return {
      statusCode: 200,
      body: JSON.stringify({
        message: "File uploaded successfully",
        file: fileName
      })
    };

  } catch (error) {
    console.error(error);

    return {
      statusCode: 500,
      body: JSON.stringify({ error: error.message })
    };
  }
};