import { S3Client, GetObjectCommand, PutObjectCommand } from "@aws-sdk/client-s3";
import sharp from "sharp";

const s3 = new S3Client({});

export const handler = async (event) => {
  try {
    for (const record of event.Records) {

      // mensaje que viene desde SQS (que viene de S3)
      const messageBody = JSON.parse(record.body);
      const s3Event = messageBody.Records[0];

      const key = decodeURIComponent(s3Event.s3.object.key);

      // obtener archivo desde S3
      const obj = await s3.send(new GetObjectCommand({
        Bucket: process.env.BUCKET,
        Key: key
      }));

      // convertir stream a buffer
      const chunks = [];
      for await (const chunk of obj.Body) {
        chunks.push(chunk);
      }
      const buffer = Buffer.concat(chunks);

      // procesar imagen (resize 40x40)
      const output = await sharp(buffer)
        .resize(40, 40)
        .png()
        .toBuffer();

      // nueva ruta
      const newKey = key.replace("uploads/", "processed/");

      // guardar imagen procesada
      await s3.send(new PutObjectCommand({
        Bucket: process.env.BUCKET,
        Key: newKey,
        Body: output,
        ContentType: "image/png"
      }));
    }

    return { statusCode: 200 };

  } catch (error) {
    console.error(error);
    throw error;
  }
};