package com.fithawaii.util;

import java.io.IOException;
import org.apache.commons.lang3.exception.ExceptionUtils;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.StringEntity;
import org.apache.http.util.EntityUtils;
import org.springframework.beans.factory.annotation.Autowired;

public class FitHttpClient {

	@Autowired
	private HttpClient httpClient;

	public String sendRequestByJson(String url, String jsonParam) {

		HttpPost httpPost = new HttpPost(url);
		httpPost.addHeader("Accept", "*/*");
		httpPost.addHeader("Content-Type", "application/xml;charset=UTF-8");
		HttpEntity entity = new StringEntity(jsonParam, ContentType.APPLICATION_JSON);
		httpPost.setEntity(entity);
		HttpResponse response;
		String result = "";
		try {
			response = httpClient.execute(httpPost);
			if (response.getStatusLine().getStatusCode() == HttpStatus.SC_OK) {
				result = EntityUtils.toString(response.getEntity());
			} else {
				System.out.println("HttpClient error getStatusCode : " + response.getStatusLine().getStatusCode());
			}

		} catch (Exception e) {
			System.out.println("HttpClient error : " + ExceptionUtils.getStackTrace(e));
		}
		return result;
	}

    public String sendRequest(String url, String param) {

        HttpPost httpPost = new HttpPost(url);
        httpPost.addHeader("Accept", "*/*");
//        httpPost.addHeader("Content-Type", "application/x-www-form-urlencoded");
        HttpEntity entity = new StringEntity(param, ContentType.APPLICATION_FORM_URLENCODED);
        httpPost.setEntity(entity);
        HttpResponse response;
        String result = "";
        try {
            response = httpClient.execute(httpPost);
            if (response.getStatusLine().getStatusCode() == HttpStatus.SC_OK) {
                result = EntityUtils.toString(response.getEntity());
            } else {
                System.out.println("HttpClient error getStatusCode : " + response.getStatusLine().getStatusCode());
            }

        } catch (Exception e) {
            System.out.println("HttpClient error : " + ExceptionUtils.getStackTrace(e));
        }
        return result;
    }

    public String sendRequestByJsonError(String url, String jsonParam) {

		HttpPost httpPost = new HttpPost(url);
		httpPost.addHeader("Accept", "*/*");
		httpPost.addHeader("Content-Type", "application/xml;charset=UTF-8");
		HttpEntity entity = new StringEntity(jsonParam, ContentType.APPLICATION_JSON);
		httpPost.setEntity(entity);
		HttpResponse response;
		String result = "";
		try {
			throw new IOException("error Test");

		} catch (Exception e) {
			System.out.println("HttpClient error : " + ExceptionUtils.getStackTrace(e));
		}
		return result;
	}

	public String sendRequestByGet(String getUrl) {
		String result = "";
		try {
			System.out.println("getUrl : " + getUrl);
			HttpGet httpget = new HttpGet(getUrl);

			HttpResponse response = httpClient.execute(httpget);
			HttpEntity entity = response.getEntity();

			System.out.println(" response.getStatusLine : " + response.getStatusLine());
			if (entity != null) {
				result = EntityUtils.toString(response.getEntity());
				System.out.println("Response content : " + result);
				EntityUtils.consume(entity);
			}
		} catch (Exception e) {
			System.out.println("sendRequest url : " + getUrl + ", error : " + ExceptionUtils.getStackTrace(e));
		} finally {
			// httpClient.getConnectionManager().shutdown();
		}

		return result;
	}

	public HttpClient getHttpClient() {
		return httpClient;
	}

	public void setHttpClient(HttpClient httpClient) {
		this.httpClient = httpClient;
	}
}
