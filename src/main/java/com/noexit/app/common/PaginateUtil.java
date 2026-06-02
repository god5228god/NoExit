package com.noexit.app.common;

import org.springframework.stereotype.Service;

@Service
public class PaginateUtil {

	public int pageCount(int dataCount, int size) {
		if (dataCount <= 0 || size <= 0) {
			return 0;
		}

		return dataCount / size + (dataCount % size > 0 ? 1 : 0);
	}

	public String paging(int currentPage, int totalPage, String listUrl) {

		if (currentPage < 1 || totalPage < 1)
			return "";

		if (currentPage > totalPage)
			currentPage = totalPage;

		int blockSize = 10;

		StringBuilder sb = new StringBuilder();

		String connector = listUrl.contains("?") ? "&" : "?";
		String fullUrl = listUrl + connector;

		// 표시할 페이지 -1
		int currentBlock = ((currentPage - 1) / blockSize) * blockSize;

		// 반복할 시작과 마지막 페이지 번호
		int startPage = currentBlock + 1;
		int endPage = Math.min(startPage + blockSize - 1, totalPage);

		sb.append("<div class='paginate'>");

		// 처음과 이전페이지
		if (currentBlock > 0) {
			int prevBlockPage = startPage - 1;
			sb.append(createLinkUrl(fullUrl, 1, "&#x226A", "처음"));
			sb.append(createLinkUrl(fullUrl, prevBlockPage, "&#x003C", "이전"));
		}

		// 페이지 반복
		for (int i = startPage; i <= endPage; i++) {

			if (i == currentPage)
				sb.append("<span class='active' aria-current='page'>").append(i).append("</span>");
			else
				sb.append(createLinkUrl(fullUrl, i, String.valueOf(i), String.valueOf(i)));
		}
		
		// 다음페이지와 끝
		if (endPage < totalPage) {
			int nextBlockPage = endPage + 1;

			sb.append(createLinkUrl(fullUrl, nextBlockPage, "&#x003E", "다음"));
			sb.append(createLinkUrl(fullUrl, totalPage, "&#x226B", "마지막"));

		}

		sb.append("</div>");

		return sb.toString();

	}

	protected String createLinkUrl(String url, int page, String label, String title) {
		return String.format("<a href='%spage=%d' title='%s'>%s</a>", url, page, title, label);
	}

}
